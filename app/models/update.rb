require 'csv'

class Update < ApplicationRecord
	serialize :updatedata

	attr_accessor :data_file, :data_type, :path, :file

	def self.parse_csv(path, data_type, update)
	    if data_type == 'Trail'
        update.parse_trails(path)
			elsif data_type == 'Pointsofinterest'
				update.parse_pois(path)
			elsif data_type == 'trails_descs'
				update.parse_trails_descs(path)
			end
			update.status = "Changes Staged"
			update.save
			ApplicationController.renderer.render(
				partial: 'updates/status',
				formats: [:js],
				handlers: [:erb]
			)
	end

	def parse_trails(file)
	    # logger.info "file_ident = #{file_ident}"
	    # contents = File.read(file_ident)
		trails_infos_to_update = []
		trails_to_update = []
		trail_systems_to_update = []
		trail_subtrails_to_update = []
		ids_in_csv = []
		systems_in_csv = []
		trail_subtrails_in_csv = []
		all_updates = {}
		
		row_count = 0
		CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
			row_count = row_count + 1
			logger.info "row = #{row}"
		  next if (row.to_s =~ /^source/)
		  #logger.info "this row = #{row}"
		  trails_info_item = TrailsInfo.find_or_initialize_by(trail_info_id: row['trail_info_id'])
		  trails_item = NewTrail.find_or_initialize_by(trails_id: row['trail_info_id'])
		  trail_system_item = TrailSystem.find_or_initialize_by(trail_subsystem: row['trail_subsystem'])

		  value = row['off_fpdcc']
		  unless value.nil?
	          value = value.squish
	          if value.to_s.downcase == "yes" || value == "Y" || value == "t"
	            value = "y"
	          end
	          if value.to_s.downcase == "no" || value == "N" || value == "f"
	            value = "n"
	          end
	      end
		  trail_subtrail_item = TrailSubtrail.find_or_initialize_by(trail_subsystem: row['trail_subsystem'], trail_color: row['trail_color'],trail_type: row['trail_type'], segment_type: row['segment_type'], direction: row['direction'], off_fpdcc: value)
		  ids_in_csv.push(row['trail_info_id'])
		  systems_in_csv.push(row['trail_subsystem'])
		  trail_subtrails_in_csv.push(trail_subtrail_item.create_subtrail_id)
		  trails_info_attrs = {}
		  trails_attrs = {}
		  trail_system_attrs = {}
		  trail_subtrail_attrs = {}
		  row.headers.each do |header|
		    value = row[header]
		    next if header == "id"
		    unless value.nil?
		      value = value.squish
		      if value.to_s.downcase == "yes" || value == "Y" || value == "t"
		        value = "y"
		      end
		      if value.to_s.downcase == "no" || value == "N" || value == "f"
		        value = "n"
		      end
		    end
		    # Build Trails Info Attrs
		    if trails_info_item.attributes.has_key? header
		      trails_info_attrs[header] = value
		    else
		      #p "Field not in trails_info_attrs: #{header}"
		    end
		    # Build Trails Attrs
		    if trails_item.attributes.has_key? header
		      trails_attrs[header] = value
		    else
		      #p "Field not in trails_attrs: #{header}"
		    end
		    # Build Trail System Attrs
		    if trail_system_item.attributes.has_key? header
		      trail_system_attrs[header] = value
		    else
		      #p "Field not in trail_system_attrs: #{header}"
		    end
		    # Build Trail Subtrail Attrs
		    if header != 'length_mi' and trail_subtrail_item.attributes.has_key? header
		      trail_subtrail_attrs[header] = value
		    else
		      #p "Field not in trail_system_attrs: #{header}"
		    end
		    if header == 'trail_info_id'
		      trails_info_attrs['trails_id'] = value
		      trails_attrs['trails_id'] = value
		    end
	  	end
	  	# Determine adds + changes for trails_info
		  trails_info_item.assign_attributes(trails_info_attrs)
		  parsed_item = {}
		  parsed_item['id'] = trails_info_item.id
		  parsed_item['changes'] = trails_info_item.changes
		  if trails_info_item.new_record?
		  	parsed_item['type'] = "Add"
		  	trails_infos_to_update.push(parsed_item)
		  elsif trails_info_item.changed?
		  	parsed_item['type'] = "Update"
		  	trails_infos_to_update.push(parsed_item)
		  end
		  # Determine adds + changes for New Trails
		  trails_item.assign_attributes(trails_attrs)
		  parsed_item = {}
		  parsed_item['id'] = trails_item.id
		  parsed_item['changes'] = trails_item.changes
		  if trails_item.new_record?
		  	parsed_item['type'] = "Add"
		  	trails_to_update.push(parsed_item)
		  elsif trails_item.changed?
		  	parsed_item['type'] = "Update"
		  	trails_to_update.push(parsed_item)
		  end
		  # Determine adds + changes for Trail System
		  trail_system_item.assign_attributes(trail_system_attrs)
		  parsed_item = {}
		  parsed_item['id'] = trail_system_item.id
		  parsed_item['changes'] = trail_system_item.changes
		  if trail_system_item.new_record?
		  	parsed_item['type'] = "Add"
		  	trail_systems_to_update.push(parsed_item)
		  elsif trail_system_item.changed?
		  	parsed_item['type'] = "Update"
		  	trail_systems_to_update.push(parsed_item)
		  end

		  # Determine adds + changes for Trail Subtrail
		  trail_subtrail_item.assign_attributes(trail_subtrail_attrs)
		  parsed_item = {}
		  parsed_item['id'] = trail_subtrail_item.id
		  parsed_item['changes'] = trail_subtrail_item.changes
		  if trail_subtrail_item.new_record?
		  	parsed_item['type'] = "Add"
		  	trail_subtrails_to_update.push(parsed_item)
		  elsif trail_subtrail_item.changed?
		  	parsed_item['type'] = "Update"
		  	trail_subtrails_to_update.push(parsed_item)
		  end
		end
		logger.info "row_count = #{row_count}"
		ids_in_csv.uniq!
		#logger.info "ids_in_csv = #{ids_in_csv}"
		# puts ids_in_csv.size()
		# Find TrailsInfo that could be deleted
		TrailsInfo.where.not(trail_info_id: ids_in_csv).find_each(batch_size: 20000) do |trailinfo|
			parsed_item = {}
		  	parsed_item['id'] = trailinfo.trail_info_id
		  	parsed_item['type'] = "Delete"
		  	trails_infos_to_update.push(parsed_item)
		end
		# Find Trails that could be deleted
		NewTrail.where.not(trails_id: ids_in_csv).find_each(batch_size: 20000) do |trail|
			parsed_item = {}
		  	parsed_item['id'] = trail.trails_id
		  	parsed_item['type'] = "Delete"
		  	trails_to_update.push(parsed_item)
		end
		# Find TrailSystems that could be deleted
		TrailSystem.find_each(batch_size: 5000) do |trailsystem|
		  if !(systems_in_csv.include?(trailsystem.trail_subsystem))
		  	parsed_item = {}
		  	parsed_item['trail_subsystem'] = trailsystem.trail_subsystem
		  	parsed_item['type'] = "Delete"
		  	trail_systems_to_update.push(parsed_item)
		  end
		end
		# Find Trail Subtrails that could be deleted
		TrailSubtrail.find_each(batch_size: 10000) do |trailsubtrail|
		  if !(trail_subtrails_in_csv.include?(trailsubtrail.create_subtrail_id))
		  	parsed_item = {}
		  	parsed_item['subtrail_id'] = trailsubtrail.create_subtrail_id
		  	parsed_item['type'] = "Delete"
		  	trail_subtrails_to_update.push(parsed_item)
		  end
		end

		self.updatedata['TrailsInfo'] = trails_infos_to_update
		self.updatedata['NewTrail'] = trails_to_update
		self.updatedata['TrailSystem'] = trail_systems_to_update
		self.updatedata['TrailSubtrail'] = trail_subtrails_to_update
		self.save
		File.delete(file)
		return self.updatedata
		#print trail_systems_to_update
	end

	def parse_pois(file)
		pois_to_update = []
		ids_in_csv = []
		row_count = 0
		CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
			row_count = row_count + 1
			logger.info "row = #{row}"
			next if (row.to_s =~ /^source/)
			#logger.info "this row = #{row}"
			poi_item = Pointsofinterest.find_or_initialize_by(poi_info_id: row['poi_info_id'])
		 
			ids_in_csv.push(row['poi_info_id'])
			poi_attrs = {}
			row.headers.each do |header|
				value = row[header]
				next if header == "id"
				unless value.nil?
					value = value.squish
					if value.to_s.downcase == "yes" || value == "Y" || value == "t"
						value = "y"
					end
					if value.to_s.downcase == "no" || value == "N" || value == "f"
						value = "n"
					end
				end
				# Build poi Info Attrs
				if poi_item.attributes.has_key? header
					poi_attrs[header] = value
				else
					#p "Field not in trails_info_attrs: #{header}"
				end
				end
				# Determine adds + changes for trails_info
			poi_item.assign_attributes(poi_attrs)
			parsed_item = {}
			parsed_item['id'] = poi_item.id
			parsed_item['changes'] = poi_item.changes
			if poi_item.new_record?
				parsed_item['type'] = "Add"
				pois_to_update.push(parsed_item)
			elsif poi_item.changed?
				parsed_item['type'] = "Update"
				pois_to_update.push(parsed_item)
			end
		end

		ids_in_csv.uniq!
		Pointsofinterest.where.not(poi_info_id: ids_in_csv).find_each(batch_size: 20000) do |poi|
			parsed_item = {}
			parsed_item['id'] = poi.poi_info_id
			parsed_item['type'] = "Delete"
			pois_to_update.push(parsed_item)
		end

		self.updatedata['Pointsofinterest'] = pois_to_update
		self.save
		File.delete(file)
		return self.updatedata
end

	# def parse_trails_descs(contents)
	# 	to_update = []
	# 	ids_in_csv = []
	# 	all_updates = {}

	# 	CSV.parse(contents, headers: true, header_converters: :downcase) do |row|
	#       next if (row.to_s =~ /^source/)
	#       trails_desc_item = TrailsDesc.find_or_initialize_by(trail_desc_id: row['trail_desc_id'])
	#       ids_in_csv.push(row['trail_desc_id'])
	# 	  trails_desc_attrs = {}
	#       row.headers.each do |header|
	#         value = row[header]
	#         next if header == "id"
	#         unless value.nil?
	#           value = value.squish
	#           if value.to_s.downcase == "yes" || value == "Y"
	#             value = "y"
	#           end
	#           if value.to_s.downcase == "no" || value == "N"
	#             value = "n"
	#           end
	#         end
	#         # next if header == "source"
	#         if trails_desc_item.attributes.has_key? header
	#           trails_desc_attrs[header] = value
	#         else
  #             p "Field not in database: #{header}"
	#         # elsif header == "source"
	#         #new_item.source = Organization.find_by code: value
	#         # elsif header == "steward"
	#         #   new_item.steward = Organization.find_by code: value
	#         end
	#         trails_desc_item.assign_attributes(trails_desc_attrs)
	# 	    parsed_item = {}
	# 	    parsed_item['id'] = trails_desc_item.id
	# 	    parsed_item['changes'] = trails_desc_item.changes
	# 	    if trails_desc_item.new_record?
	# 	  	  parsed_item['type'] = "Add"
	# 	  	  to_update.push(parsed_item)
	# 	    elsif trails_desc_item.changed?
	# 	  	  parsed_item['type'] = "Update"
	# 	  	  to_update.push(parsed_item)
	# 	    end
	#       end
	#     end
	#     ids_in_csv.uniq!
	#     TrailsDesc.where.not(trail_desc_id: ids_in_csv).find_each(batch_size: 20000) do |item|
	# 		parsed_item = {}
	# 	  	parsed_item['id'] = item.trail_desc_id
	# 	  	parsed_item['type'] = "Delete"
	# 	  	to_update.push(parsed_item)
	# 	end
	# 	all_updates['trails_desc'] = to_update
	# 	self.updatedata = self.updatedata.merge(all_updates)
	# 	self.save
	# 	return self.updatedata
	# end
	#handle_asynchronously :parse_trails_descs

	# def parse_pois(contents)
	# 	all_updates = {}
	# 	self.updatedata['Pointsofinterest'] = Pointsofinterest.parse_csv(contents)
	# 	self.save
	# 	#UpdatesController.render(js: 'update_results')  
	# 	# rendered_string = ApplicationController.render(
	# 	#   template: 'updates/update_results.js.erb'		)
	# 	return self.updatedata
	# end
	# #handle_asynchronously :parse_pois

	# def parse_activities(contents)

	# end

	def perform_update
		self.updatedata.each do |this_model, records|
			records.each do |record|
				new_updates = {}
				if record['changes'].present?
					record['changes'].each do |change|
						new_updates[change[0]] = change[1][1]
					end
					logger.info record['id']
					logger.info new_updates
				end
				if record['type'] == 'Update'
					to_change = this_model.classify.constantize.find(record['id'])
					change_result = to_change.update!(new_updates)
					record['result'] = change_result ? "Updated" : "Not Updated"
					#change_result
				elsif record['type'] == 'Delete'
					to_change = this_model.classify.constantize.find(record['id'])
					change_result = to_change.destroy
					record['result'] = change_result
				elsif record['type'] == 'Add'
					logger.info "Add placeholder"
					to_change = Pointsofinterest.new
					change_result = to_change.update_attributes(new_updates)
					record['result'] = change_result ? "Created" : "Not Created"
				end
			end
		end
		self.run_at = Time.now
		self.status = "Changes Completed"
		self.save
	end

end
