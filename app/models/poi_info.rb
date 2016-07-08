class PoiInfo < ActiveRecord::Base
	self.primary_key = 'poi_info_id'
	
	has_one :poi_desc, foreign_key: :poi_info_id, primary_key: :poi_info_id
	has_one :poi_amenity, foreign_key: :poi_info_id, primary_key: :poi_info_id
	has_many :activities, foreign_key: :poi_info_id, primary_key: :poi_info_id

  def self.parse_csv(file)
    parsed_poi_infos = []
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
      new_poi_info = PoiInfo.new
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
        if new_poi_info.attributes.has_key? header
          new_poi_info[header] = value
        # elsif header == "source"
        #new_poi_info.source = Organization.find_by code: value
        # elsif header == "steward"
        #   new_poi_info.steward = Organization.find_by code: value
        end
      end
      parsed_poi_infos.push new_poi_info
    end
    parsed_poi_infos
  end

end
