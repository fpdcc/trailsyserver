class TrailSystem < ActiveRecord::Base
  self.per_page = 15

  has_many :alertings, :as => :alertable
  has_many :alerts, :through => :alertings

  accepts_nested_attributes_for :alertings
  accepts_nested_attributes_for :alerts


  def self.parse_csv(file)
	parsed_items = []
	systems_to_add = []
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
	      if header == "trail_subsystem"
	      	#p "#{header} = #{value}"
	        exist_count = TrailSystem.where(trail_subsystem: value).count
	        #p "exist_count = #{exist_count}"
	        if exist_count == 0
	          unless systems_to_add.include?(value)
	            new_item = TrailSystem.new
	            new_item['trail_subsystem'] = value
	            systems_to_add.push value
	            parsed_items.push new_item
	          end
	        end
	      end
	    end
	  end
	end
	p "parsed_items = #{parsed_items}"
	parsed_items
  end

end
