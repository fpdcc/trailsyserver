class TrailsInfo < ApplicationRecord
	self.primary_key = 'trail_info_id'
	belongs_to :new_trail, foreign_key: :trails_id, primary_key: :trail_info_id
	has_one  :trails_desc, foreign_key: :trail_subsystem, primary_key: :trail_subsystem
	has_many :trails_infos, foreign_key: :trail_subsystem, primary_key: :trail_subsystem
	has_many :subsystem_trails, class_name: "TrailsInfo",
                          foreign_key: :trail_subsystem, primary_key: :trail_subsystem
	
	has_many :activities, foreign_key: :trail_info_id, primary_key: :trail_info_id
	has_many :pointsofinterests, through: :activities

	default_scope {where(web_trail: 'y')}
	self.per_page = 15

	before_save :create_direct_trail_id
  	before_save :create_direct_trail_name

  	def create_direct_trail_id
  	  logger.info("starting create_direct_trail_id")
      direct_trail_id = self.trail_subsystem + "-"
      items_array = [self.trail_color, trail_type, segment_type, direction, off_fpdcc]
      items_array.each do |item|
          if item.present?
          direct_trail_id = direct_trail_id + item
        end
        direct_trail_id = direct_trail_id + "-"
      end
      self.direct_trail_id = direct_trail_id
    end

    def create_direct_trail_name
      logger.info("starting create_direct_trail_name")
      segment_name = ""
      items_array = [trail_color, trail_type, segment_type]
      items_array.each do |item|
          if item.present?
          segment_name += ' ' + item
        end
      end
      if ( off_fpdcc === 'y' )
        segment_name += ' (Non-FPCC)'
      elsif direction
        segment_name += ' (' + direction + ')'
      end 
      self.direct_trail_name = segment_name.strip.titlecase
    end


	#scope :small, :group {:trail_subsystem, :trail_color}

	# subtrail_length_mi finds the total length for all trail segments with the same trail_subsystem, trail_color, and trail_type. This is used to show length on detail panel trail segments.
	def subtrail_length_mi
		TrailsInfo.where(trail_subsystem: trail_subsystem, trail_color: trail_color, trail_type: trail_type, segment_type: segment_type, direction: direction, off_fpdcc: off_fpdcc).sum(:length_mi)
	end

	def subsystem_subtrails
		self.subsystem_trails.sort_by(&:subtrail_length_mi).reverse.map(&:subtrail_name).uniq
	end

	# def subsystem_subtrails
	# 	TrailsInfo.where(trail_subsystem: trail_subsystem).
	# 	TrailsInfo.select(:trail_subsystem, :trail_color, :trail_type, :segment_type, :direction, :off_fpdcc, 

	# end

	def self.sorted_by_subtrail_length_mi
	  TrailsInfo.all.sort_by(&:subtrail_length_mi).reverse
	end

	def maintenance_div
		maintenance
	end

	def self.all_trail_subsystem_names
	  TrailsInfo.select("DISTINCT(trails_infos.trail_subsystem), trails_infos.trail_subsystem, trails_infos.trail_info_id")
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
	          value = value.squish
	          if value.to_s.downcase == "yes" || value == "Y" || value == "t"
	            value = "y"
	          end
	          if value.to_s.downcase == "no" || value == "N" || value == "f"
	            value = "n"
	          end
	        end
	        # next if header == "source"
	        if new_item.attributes.has_key? header
	          new_item[header] = value
	        else
              p "Field not in database: #{header}"
	        # elsif header == "source"
	        #new_item.source = Organization.find_by code: value
	        # elsif header == "steward"
	        #   new_item.steward = Organization.find_by code: value
	        end
	        if header == 'trail_info_id'
	          new_item['trails_id'] = value
	        end
	      end
	      parsed_items.push new_item
	    end
	    parsed_items
	end

end
