class Picnicgrofe < ActiveRecord::Base
	self.primary_key = "picnicgrove_id"

	belongs_to :poi_info, foreign_key: :poi_info_id, primary_key: :poi_info_id

	default_scope {where(status: 'active')}

	self.per_page = 15

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
	      new_item = Picnicgrofe.new
	      next if (row.to_s =~ /^source/)

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
	        if new_item.attributes.has_key? header
	          new_item[header] = value
	        elsif header == 'type'
	          new_item['picnicgrove_type'] = value
	        else
              p "Field not in database: #{header}"
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
