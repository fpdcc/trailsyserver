require 'active_support/concern'

module Uploadable

  extend ActiveSupport::Concern

  def self.parse_trails(file)
  	CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
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
        if new_item.attributes.has_key? header
          new_item[header] = value
        else
          p "Field not in database: #{header}"
        end
        if header == 'trail_info_id'
          new_item['trails_id'] = value
        end
      end
      parsed_items.push new_item
    end
  end

  def self.read_csv(file)
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
  end


  def active_alerts_count
  	self.alertings.active.count
  end

  def self.with_active_alerts

  end
end
