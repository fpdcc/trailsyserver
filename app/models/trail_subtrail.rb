class TrailSubtrail < ApplicationRecord
	self.primary_key = 'subtrail_id'
	before_save :create_subtrail_id
  	before_save :create_subtrail_name
  	belongs_to :trail_system, foreign_key: :trail_subsystem, primary_key: :trail_subsystem
  	has_many :trails_infos, foreign_key: :direct_trail_id, primary_key: :subtrail_id
	has_many :activities, through: :trails_infos
	has_many :pointsofinterests, through: :activities
	has_many :alertings, primary_key: :subtrail_id
	has_many :alerts, through: :alertings

	include Alertable

	def self.generate_length_mi
		TrailSubtrail.all.each do |trail_subtrail|
			trail_subtrail.length_mi = trail_subtrail.trails_infos.sum(:length_mi)
			trail_subtrail.save
		end
	end

	#scope :desc_length, order(&:subtrail_mi).reverse

  	def create_subtrail_id
  	  logger.info("starting create_direct_trail_id")
      direct_trail_id = trail_subsystem + "-"
      items_array = [trail_color, trail_type, segment_type, direction, off_fpdcc]
      items_array.each do |item|
          if item.present?
          	direct_trail_id = direct_trail_id + item
        end
        direct_trail_id = direct_trail_id + "-"
      end
      self.subtrail_id = direct_trail_id
    end

    def create_subtrail_name
      logger.info("starting create_direct_trail_name")
      segment_name = ""

      items_array = [trail_color, trail_type, segment_type]
      items_array.each do |item|
          if item.present?
          segment_name += ' ' + item
        end
      end
      segment_name = segment_name.strip.titlecase
      if ( off_fpdcc === 'y' )
        segment_name += ' (Non-FPCC)'
      elsif direction
        segment_name += ' (' + direction.titlecase + ')'
      end 
      self.subtrail_name = segment_name
    end

    def self.parse_csv(file)
	    parsed_items = []
	    parsed_hashes = {}
	    subtrails_to_add = []
	    this_model = TrailSubtrail.new
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
	      new_hash = {}   
	      next if (row.to_s =~ /^source/)
	      new_hash['trail_subsystem'] = row['trail_subsystem']
	      new_hash['trail_color'] = row['trail_color']
	      new_hash['trail_type'] = row['trail_type']
	      new_hash['segment_type'] = row['segment_type']
	      new_hash['direction'] = row['direction']
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
	      new_hash['off_fpdcc'] = value
	      # row.headers.each do |header|
	      #   value = row[header]
	      #   next if header == "id"
	      #   unless value.nil?
	      #     value = value.squish
	      #     if value.to_s.downcase == "yes" || value == "Y" || value == "t"
	      #       value = "y"
	      #     end
	      #     if value.to_s.downcase == "no" || value == "N" || value == "f"
	      #       value = "n"
	      #     end
	      #   end
	      #   # next if header == "source"
	      #   if this_model.attributes.has_key? header
	      #     new_hash[header] = value
	      #   else
       #        #p "Field not in database: #{header}"
	      #   end
	      # end
	      parsed_items.push new_hash
	    end
	    p "parsed_items count: #{parsed_items.count}"
	    parsed_items = parsed_items.uniq
	    p "parsed_items uniq count: #{parsed_items.count}"
	    parsed_items.each do |item|
	   	  subtrails_to_add.push(TrailSubtrail.new(item))
	    end
	    p "subtrails_to_add count: #{subtrails_to_add.count}"

	    subtrails_to_add
	end

end
