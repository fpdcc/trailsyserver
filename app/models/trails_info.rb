class TrailsInfo < ActiveRecord::Base
	self.primary_key = 'trail_info_id'
	belongs_to :new_trail, foreign_key: :trails_id, primary_key: :trails_id
	has_many :poi_to_trails, foreign_key: :trail_info_id, primary_key: :trail_info_id
	has_many :poi_infos, through: :poi_to_trails
	has_one  :trails_desc, foreign_key: :trail_subsystem, primary_key: :trail_subsystem
	default_scope {where(web_trail: 'y')}
	#scope :unique_styles, -> {group("trail_subsystem"), order("trail_subsystem asc")}

	#named_scope :small, :group => {:trail_subsystem, :trail_color}}

	# subtrail_length_mi finds the total length for all trail segments with the same trail_subsystem, trail_color, and trail_type. This is used to show length on detail panel trail segments.
	def subtrail_length_mi
		TrailsInfo.where(trail_subsystem: trail_subsystem, trail_color: trail_color, trail_type: trail_type).sum(:length_mi)
	end

	def trail_subsystem_alt_names
		TrailsInfo.where(trail_subsystem: trail_subsystem).pluck('alt_name').uniq.reject(&:blank?)
	end

	def self.parse_csv(file)
	    parsed_items = []
	    if file.class == ActionDispatch::Http::UploadedFile
	      file_ident = file.path
	    else
	      file_ident = file
	    end

	    # if the encoding is bad, assume windows-1252
	    
	    contents = File.read(file_ident)
	    unless contents.valid_encoding?
	      contents.encode!("utf-8", "windows-1252", :invalid => :replace)
	    end

	    CSV.parse(contents, headers: true, header_converters: :downcase) do |row|
	      new_item = TrailsInfo.new
	      next if (row.to_s =~ /^source/)

	      row.headers.each do |header|
	        value = row[header]
	        next if header == "id"
	        unless value.nil?
	          if value.to_s.downcase == "yes" || value == "Y"
	            value = "y"
	          end
	          if value.to_s.downcase == "no" || value == "N"
	            value = "n"
	          end
	        end
	        # next if header == "source"
	        if new_item.attributes.has_key? header
	          new_item[header] = value
	        # elsif header == "source"
	        #new_item.source = Organization.find_by code: value
	        # elsif header == "steward"
	        #   new_item.steward = Organization.find_by code: value
	        end
	      end
	      parsed_items.push new_item
	    end
	    parsed_items
	end

end
