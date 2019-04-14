class TrailsInfo < ApplicationRecord
	self.primary_key = 'trail_info_id'
	has_one  :trails_desc, foreign_key: :trail_subsystem_id, primary_key: :trail_subsystem_id
	has_many :trails_infos, foreign_key: :trail_subsystem_id, primary_key: :trail_subsystem_id
	has_many :subsystem_trails, class_name: "TrailsInfo",
                          foreign_key: :trail_subsystem_id, primary_key: :trail_subsystem_id
	has_many :subtrail_trails, class_name: "TrailsInfo",
                          foreign_key: :direct_trail_id, primary_key: :direct_trail_id
	has_many :activities, foreign_key: :trail_info_id, primary_key: :trail_info_id
	has_many :pointsofinterests, through: :activities
	has_one :trail_subtrail, foreign_key: :subtrail_id, primary_key: :direct_trail_id

	default_scope {where(web_trail: 'y')}
	self.per_page = 15

	before_save :create_direct_trail_id
  	before_save :create_direct_trail_name

  	def create_direct_trail_id
  	  logger.info("starting create_direct_trail_id")
      direct_trail_id = trail_subsystem_id + "-"
      items_array = [trail_name, trail_color, trail_type, segment_type, direction, off_fpdcc]
      items_array.each do |item|
        if item.present?
          direct_trail_id = direct_trail_id + item
        end
        direct_trail_id = direct_trail_id + "-"
      end
      self.direct_trail_id = direct_trail_id.parameterize
    end

    def create_direct_trail_name
      logger.info("starting create_direct_trail_name")
			segment_name = ""
			if trail_name.present?
				segment_name = trail_name
			else
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
			end
			self.direct_trail_name = segment_name.strip.titlecase
		end
		
		def self.create_all_names
			TrailsInfo.all.each do |ti|
				ti.create_direct_trail_name
				ti.save
			end
		end


	#scope :small, :group {:trail_subsystem, :trail_color}

	# subtrail_length_mi finds the total length for all trail segments with the same trail_subsystem, trail_color, and trail_type. This is used to show length on detail panel trail segments.
	def subtrail_length_mi
		self.subtrail_trails.sum(:length_mi)
	end

	def subtrail_tags
		subtrails = self.subtrail_trails
    tags = {}
    panelTags = []
		searchTags = []
		atList = subtrails.pluck(:hiking)
		if (atList.count(1) > atList.count(0))
			panelTags.push("hiking")
		end
		atList = subtrails.pluck(:biking)
		if (atList.count(1) > atList.count(0))
			panelTags.push("biking")
		end
		atList = subtrails.pluck(:equestrian)
		if (atList.count(1) > atList.count(0))
			panelTags.push("equestrian")
		end
		atList = subtrails.pluck(:cross_country)
		if (atList.count(1) > atList.count(0))
			panelTags.push("cross_country")
		end
		atList = subtrails.pluck(:no_dogs)
		if (atList.count(1) > atList.count(0))
			panelTags.push("no_dogs")
		end
		atList = subtrails.pluck(:dog_leash)
		if (atList.count(1) > atList.count(0))
			panelTags.push("dog_leash")
		end

		panelTags = panelTags.uniq
		searchTags = searchTags.uniq
		tags = {panel: panelTags, search: searchTags}
		tags
	end

	# def subsystem_subtrails
	# 	self.subsystem_trails.sort_by(&:subtrail_length_mi).reverse.map(&:subtrail_name).uniq
	# end

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
	    
	    # if file.class == ActionDispatch::Http::UploadedFile
	    #   file_ident = file.path
	    # else
	    #   file_ident = file
	    # end

	    # if the encoding is bad, assume windows-1252
	    
	    # contents = File.read(file_ident)
	    # unless contents.valid_encoding?
	    #   contents.encode!("utf-8", "windows-1252", :invalid => :replace)
	    # end
			    CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
			     #CSV.parse(contents, headers: true, header_converters: :downcase) do |row|
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
