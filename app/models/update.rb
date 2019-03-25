require 'csv'

class Update < ApplicationRecord
	serialize :updatedata
	enum status: [:created, :staged, :approved, :success, :failure]

	attr_accessor :data_file, :data_type, :path, :file

	def self.parse_csv(path, data_type, update)
		if data_type == 'Trail'
			update.parse_trails(path)
		elsif data_type == 'Pointsofinterest'
			update.parse_pois(path)
		elsif data_type == 'TrailsDesc'
			update.parse_trails_descs(path)
		elsif data_type == 'Activity'
			update.parse_activities(path)
		elsif data_type == 'ParkingEntrance'
			update.parse_parking_entrances(path)
		elsif data_type == 'Picnicgrofe'
			update.parse_picnicgroves(path)
		elsif data_type == 'PoiDesc'
			update.parse_poi_descs(path)
		end
		update.status = "staged"
		update.save
		# ApplicationController.renderer.render(
		# 	partial: 'updates/status',
		# 	formats: [:js],
		# 	handlers: [:erb]
		# )
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
		
		csv_headers = CSV.foreach(file, headers: true, header_converters: :downcase).first.headers
		trails_info_columns = TrailsInfo.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['TrailsInfo'] = {}
		self.updatedata['TrailsInfo']['columns'] = {}
		self.updatedata['TrailsInfo']['columns']['csv_missing'] = trails_info_columns - csv_headers
		self.updatedata['TrailsInfo']['columns']['csv_extra'] = csv_headers - trails_info_columns

		newtrail_columns = NewTrail.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['NewTrail'] = {}
		self.updatedata['NewTrail']['columns'] = {}
		self.updatedata['NewTrail']['columns']['csv_missing'] = newtrail_columns - csv_headers
		self.updatedata['NewTrail']['columns']['csv_extra'] = csv_headers - newtrail_columns

		trail_system_columns = TrailSystem.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['TrailSystem'] = {}
		self.updatedata['TrailSystem']['columns'] = {}
		self.updatedata['TrailSystem']['columns']['csv_missing'] = trail_system_columns - csv_headers
		self.updatedata['TrailSystem']['columns']['csv_extra'] = csv_headers - trail_system_columns

		trail_subtrail_columns = TrailSubtrail.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['TrailSubtrail'] = {}
		self.updatedata['TrailSubtrail']['columns'] = {}
		self.updatedata['TrailSubtrail']['columns']['csv_missing'] = trail_subtrail_columns - csv_headers
		self.updatedata['TrailSubtrail']['columns']['csv_extra'] = csv_headers - trail_subtrail_columns


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
			parsed_item['id'] = parsed_item['trail_subsystem']
		  	parsed_item['type'] = "Delete"
		  	trail_systems_to_update.push(parsed_item)
		  end
		end
		# Find Trail Subtrails that could be deleted
		TrailSubtrail.find_each(batch_size: 10000) do |trailsubtrail|
		  if !(trail_subtrails_in_csv.include?(trailsubtrail.create_subtrail_id))
		  	parsed_item = {}
			parsed_item['subtrail_id'] = trailsubtrail.create_subtrail_id
			parsed_item['id'] = parsed_item['subtrail_id']
		  	parsed_item['type'] = "Delete"
		  	trail_subtrails_to_update.push(parsed_item)
		  end
		end

		self.updatedata['TrailsInfo']['records'] = trails_infos_to_update.uniq
		self.updatedata['NewTrail']['records'] = trails_to_update.uniq
		self.updatedata['TrailSystem']['records'] = trail_systems_to_update.uniq
		self.updatedata['TrailSubtrail']['records'] = trail_subtrails_to_update.uniq
		self.status = "staged"
		self.save
		File.delete(file)
		return self.updatedata
		#print trail_systems_to_update
	end

	def parse_pois(file)
		pois_to_update = []
		ids_in_csv = []

		csv_headers = CSV.foreach(file, headers: true, header_converters: :downcase).first.headers
		poi_columns = Pointsofinterest.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['Pointsofinterest'] = {}
		self.updatedata['Pointsofinterest']['columns'] = {}
		self.updatedata['Pointsofinterest']['columns']['csv_missing'] = poi_columns - csv_headers
		self.updatedata['Pointsofinterest']['columns']['csv_extra'] = csv_headers - poi_columns


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

		self.updatedata['Pointsofinterest']['records'] = pois_to_update.uniq
		self.status = "staged"
		self.save
		File.delete(file)
		return self.updatedata
	end

	def parse_trails_descs(file)
		to_update = []
		ids_in_csv = []
		all_updates = {}

		csv_headers = CSV.foreach(file, headers: true, header_converters: :downcase).first.headers
		trails_desc_columns = TrailsDesc.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['TrailsDesc'] = {}
		self.updatedata['TrailsDesc']['columns'] = {}
		self.updatedata['TrailsDesc']['columns']['csv_missing'] = trails_desc_columns - csv_headers
		self.updatedata['TrailsDesc']['columns']['csv_extra'] = csv_headers - trails_desc_columns

		row_count = 0
		CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
		  row_count = row_count + 1
		  logger.info "row = #{row}"
	    next if (row.to_s =~ /^source/)
	    trails_desc_item = TrailsDesc.find_or_initialize_by(trail_desc_id: row['trail_desc_id'])
	    ids_in_csv.push(row['trail_desc_id'])
		  trails_desc_attrs = {}
	      row.headers.each do |header|
	        value = row[header]
	        next if header == "id"
	        unless value.nil?
	          value = value.squish
	          if value.to_s.downcase == "yes" || value == "Y"
	            value = "y"
	          end
	          if value.to_s.downcase == "no" || value == "N"
	            value = "n"
	          end
	        end
	        # next if header == "source"
	        if trails_desc_item.attributes.has_key? header
	          trails_desc_attrs[header] = value
	        else
              p "Field not in database: #{header}"
	        # elsif header == "source"
	        #new_item.source = Organization.find_by code: value
	        # elsif header == "steward"
	        #   new_item.steward = Organization.find_by code: value
					end
				end
	    trails_desc_item.assign_attributes(trails_desc_attrs)
		  parsed_item = {}
			parsed_item['id'] = trails_desc_item.id
			parsed_item['changes'] = trails_desc_item.changes
			if trails_desc_item.new_record?
				parsed_item['type'] = "Add"
				to_update.push(parsed_item)
			elsif trails_desc_item.changed?
				parsed_item['type'] = "Update"
				to_update.push(parsed_item)
			end
	  end
		ids_in_csv.uniq!
		TrailsDesc.where.not(trail_desc_id: ids_in_csv).find_each(batch_size: 20000) do |item|
			parsed_item = {}
			parsed_item['id'] = item.trail_desc_id
			parsed_item['type'] = "Delete"
			to_update.push(parsed_item)
		end
		self.updatedata['TrailsDesc']['records'] = to_update.uniq
		self.save
		return self.updatedata
	end

	def parse_activities(file)
		to_update = []
		ids_in_csv = []
		row_count = 0
		csv_headers = CSV.foreach(file, headers: true, header_converters: :downcase).first.headers
		activity_columns = Activity.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['Activity'] = {}
		self.updatedata['Activity']['columns'] = {}
		self.updatedata['Activity']['columns']['csv_missing'] = activity_columns - csv_headers
		self.updatedata['Activity']['columns']['csv_extra'] = csv_headers - activity_columns
		CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
			row_count = row_count + 1
			logger.info "row = #{row}"
			next if (row.to_s =~ /^source/)
			#logger.info "this row = #{row}"
			activity_item = Activity.find_or_initialize_by(activities_id: row['activities_id'])
		 
			ids_in_csv.push(row['activities_id'])
			activity_attrs = {}
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
				if activity_item.attributes.has_key? header
					activity_attrs[header] = value
				else
					#p "Field not in trails_info_attrs: #{header}"
				end
			end
				# Determine adds + changes for trails_info
			activity_item.assign_attributes(activity_attrs)
			parsed_item = {}
			parsed_item['id'] = activity_item.id
			parsed_item['changes'] = activity_item.changes
			if activity_item.new_record?
				parsed_item['type'] = "Add"
				to_update.push(parsed_item)
			elsif activity_item.changed?
				parsed_item['type'] = "Update"
				to_update.push(parsed_item)
			end
		end

		ids_in_csv.uniq!
		Activity.where.not(activities_id: ids_in_csv).find_each(batch_size: 20000) do |activity|
			parsed_item = {}
			parsed_item['id'] = activity.activities_id
			parsed_item['type'] = "Delete"
			to_update.push(parsed_item)
		end

		self.updatedata['Activity']['records'] = to_update.uniq
		self.status = "staged"
		self.save
		File.delete(file)
		return self.updatedata
	end

	def parse_parking_entrances(file)
		logger.info "starting parse_parking_entrances"
		to_update = []
		ids_in_csv = []
		row_count = 0
		csv_headers = CSV.foreach(file, headers: true, header_converters: :downcase).first.headers
		parking_entrances_columns = ParkingEntrance.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['ParkingEntrance'] = {}
		self.updatedata['ParkingEntrance']['columns'] = {}
		self.updatedata['ParkingEntrance']['columns']['csv_missing'] = parking_entrances_columns - csv_headers
		self.updatedata['ParkingEntrance']['columns']['csv_extra'] = csv_headers - parking_entrances_columns
		CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
			row_count = row_count + 1
			logger.info "row = #{row}"
			next if (row.to_s =~ /^source/)
			#logger.info "this row = #{row}"
			parking_entrance_item = ParkingEntrance.find_or_initialize_by(parking_info_id: row['parking_info_id'])
		 
			ids_in_csv.push(row['parking_info_id'])
			parking_entrance_attrs = {}
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
				if parking_entrance_item.attributes.has_key? header
					parking_entrance_attrs[header] = value
				else
					#p "Field not in trails_info_attrs: #{header}"
				end
			end
				# Determine adds + changes for trails_info
			parking_entrance_item.assign_attributes(parking_entrance_attrs)
			parsed_item = {}
			parsed_item['id'] = parking_entrance_item.id
			parsed_item['changes'] = parking_entrance_item.changes
			if parking_entrance_item.new_record?
				parsed_item['type'] = "Add"
				to_update.push(parsed_item)
			elsif parking_entrance_item.changed?
				parsed_item['type'] = "Update"
				to_update.push(parsed_item)
			end
		end

		ids_in_csv.uniq!
		ParkingEntrance.where.not(parking_info_id: ids_in_csv).find_each(batch_size: 20000) do |parking_entrance|
			parsed_item = {}
			parsed_item['id'] = parking_entrance.parking_info_id
			parsed_item['type'] = "Delete"
			to_update.push(parsed_item)
		end

		self.updatedata['ParkingEntrance']['records'] = to_update.uniq
		self.status = "staged"
		self.save
		File.delete(file)
		return self.updatedata
	end

	def parse_picnicgroves(file)
		to_update = []
		ids_in_csv = []
		row_count = 0
		csv_headers = CSV.foreach(file, headers: true, header_converters: :downcase).first.headers
		picnicgroves_columns = Picnicgrofe.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['Picnicgrofe'] = {}
		self.updatedata['Picnicgrofe']['columns'] = {}
		self.updatedata['Picnicgrofe']['columns']['csv_missing'] = picnicgroves_columns - csv_headers
		self.updatedata['Picnicgrofe']['columns']['csv_extra'] = csv_headers - picnicgroves_columns
		CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
			row_count = row_count + 1
			logger.info "row = #{row}"
			next if (row.to_s =~ /^source/)
			#logger.info "this row = #{row}"
			picnicgrove_item = Picnicgrofe.find_or_initialize_by(picnicgrove_id: row['picnicgrove_id'])
		 
			ids_in_csv.push(row['picnicgrove_id'])
			picnicgrove_attrs = {}
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
				if picnicgrove_item.attributes.has_key? header
					picnicgrove_attrs[header] = value
				else
					#p "Field not in trails_info_attrs: #{header}"
				end
			end
				# Determine adds + changes for trails_info
				picnicgrove_item.assign_attributes(picnicgrove_attrs)
			parsed_item = {}
			parsed_item['id'] = picnicgrove_item.id
			parsed_item['changes'] = picnicgrove_item.changes
			if picnicgrove_item.new_record?
				parsed_item['type'] = "Add"
				to_update.push(parsed_item)
			elsif picnicgrove_item.changed?
				parsed_item['type'] = "Update"
				to_update.push(parsed_item)
			end
		end

		ids_in_csv.uniq!
		Picnicgrofe.where.not(picnicgrove_id: ids_in_csv).find_each(batch_size: 20000) do |picnicgrovve|
			parsed_item = {}
			parsed_item['id'] = picnicgrovve.picnicgrove_id
			parsed_item['type'] = "Delete"
			to_update.push(parsed_item)
		end

		self.updatedata['Picnicgrofe']['records'] = to_update.uniq
		self.status = "staged"
		self.save
		File.delete(file)
		return self.updatedata
	end

	def parse_poi_descs(file)
		to_update = []
		ids_in_csv = []
		row_count = 0
		csv_headers = CSV.foreach(file, headers: true, header_converters: :downcase).first.headers
		poi_descs_columns = PoiDesc.column_names - ["created_at", "updated_at", "id"]
		self.updatedata['PoiDesc'] = {}
		self.updatedata['PoiDesc']['columns'] = {}
		self.updatedata['PoiDesc']['columns']['csv_missing'] = poi_descs_columns - csv_headers
		self.updatedata['PoiDesc']['columns']['csv_extra'] = csv_headers - poi_descs_columns
		CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
			row_count = row_count + 1
			logger.info "row = #{row}"
			next if (row.to_s =~ /^source/)
			#logger.info "this row = #{row}"
			poi_desc_item = PoiDesc.find_or_initialize_by(poi_desc_id: row['poi_desc_id'])
		 
			ids_in_csv.push(row['poi_desc_id'])
			poi_desc_attrs = {}
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
				if poi_desc_item.attributes.has_key? header
					poi_desc_attrs[header] = value
				else
					#p "Field not in trails_info_attrs: #{header}"
				end
			end
				# Determine adds + changes for trails_info
				poi_desc_item.assign_attributes(poi_desc_attrs)
			parsed_item = {}
			parsed_item['id'] = poi_desc_item.id
			parsed_item['changes'] = poi_desc_item.changes
			if poi_desc_item.new_record?
				parsed_item['type'] = "Add"
				to_update.push(parsed_item)
			elsif poi_desc_item.changed?
				parsed_item['type'] = "Update"
				to_update.push(parsed_item)
			end
		end

		ids_in_csv.uniq!
		PoiDesc.where.not(poi_desc_id: ids_in_csv).find_each(batch_size: 20000) do |poi_desc|
			parsed_item = {}
			parsed_item['id'] = poi_desc.poi_desc_id
			parsed_item['type'] = "Delete"
			to_update.push(parsed_item)
		end

		self.updatedata['PoiDesc']['records'] = to_update.uniq
		self.status = "staged"
		self.save
		File.delete(file)
		return self.updatedata
	end

	def perform_update
		Update.transaction do
			self.updatedata.each do |this_model, details|
				this_model.classify.constantize.transaction do
					records = details['records'].uniq
					#records = records.uniq
					records_count = records.length
					#logger.info "[perform_update] records count = #{records_count}"
					#logger.info "[perform_update] records = #{records}"
					records.each do |record|
						new_updates = {}
						logger.info "[perform_update] record = #{record}"
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
							to_change = this_model.classify.constantize.new
							change_result = to_change.update_attributes(new_updates)
							record['result'] = change_result ? "Created" : "Not Created"
						end
					end
				end
			end
		end
		self.run_at = Time.now
		self.status = "success"
		self.save
	end

end
