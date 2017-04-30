class Update < ActiveRecord::Base
	serialize :updatedata

	def self.parse_trails(file)
		trails_infos_to_update = []
		trails_to_update = []
		trail_systems_to_update = []
		ids_in_csv = []
		systems_in_csv = []
		all_updates = {}

		CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
		  next if (row.to_s =~ /^source/)
		  trails_info_item = TrailsInfo.find_or_initialize_by(trail_info_id: row['trail_info_id'])
		  trails_item = NewTrail.find_or_initialize_by(trails_id: row['trail_info_id'])
		  trail_system_item = TrailSystem.find_or_initialize_by(trail_subsystem: row['trail_subsystem'])
		  ids_in_csv.push(row['trail_info_id'])
		  systems_in_csv.push(row['trail_subsystem'])
		  trails_info_attrs = {}
		  trails_attrs = {}
		  trail_system_attrs = {}
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
		end
		ids_in_csv.uniq!
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
		all_updates['trails_infos'] = trails_infos_to_update
		all_updates['trails'] = trails_to_update
		all_updates['trail_systems'] = trail_systems_to_update
		newUpdate = Update.new(filename: file, updatedata: all_updates)
		newUpdate.save
		return newUpdate
		#print trail_systems_to_update
	end
end
