class PoiInfo < ActiveRecord::Base
	self.primary_key = 'poi_info_id'
	
	has_one :poi_desc, foreign_key: :poi_info_id, primary_key: :poi_info_id
	has_one :poi_amenity, foreign_key: :poi_info_id, primary_key: :poi_info_id
	has_many :activities, foreign_key: :poi_info_id, primary_key: :poi_info_id
	has_one :name, foreign_key: :nameid, primary_key: :nameid
	has_one :name_alt1, class_name: 'Name', foreign_key: :nameid, primary_key: :alt_nameid
	has_one :name_alt2, class_name: 'Name', foreign_key: :nameid, primary_key: :alt2_nameid
  has_many :poi_to_trails, foreign_key: :poi_info_id, primary_key: :poi_info_id
  has_many :trails_infos, through: :poi_to_trails

  def geom
    if parking_connection_id.present?
      p "Parking Connection Present."
      return ParkingEntrance.find(parking_connection_id).geom;
    else
      p "Parking Connection Not Present."
      return Pointsofinterest.find(pointsofinterest_id).geom;
    end
  end

  def trail_subsystems
    this_trails_infos = self.trails_infos
    trail_subsystems = this_trails_infos.pluck('trail_subsystem').uniq
  end

  # def direct_trail_ids  
  # end

  def tags
    this_amenity = self.poi_amenity
    tags = []
    if (this_amenity)
      if (this_amenity.bike_rental == 1)
        tags.push("bike_rental", "bike rental", "bicycle rental")
      end
      if (this_amenity.birding == 1)
        tags.push("birding", "birdwatching", "bird")
      end
      if ( (this_amenity.boat_ramp == 1) or (this_amenity.canoe == 1) or (this_amenity.boat_rental == 1) )
        tags.push("boat_rental","boat rental", "canoe", "boat_ramp", "boat ramp", "canoe rental", "kayak rental", "boating center", "canoeing", "kayaking", "boating", "kayak", "boat")
      end
      if (this_amenity.camping == 1)
        tags.push("camping","camp","campground")
      end
      if (this_amenity.cross_country == 1)
        tags.push("cross_country","cross-country skiing","ski")
      end
      if (this_amenity.cycling == 1)
        tags.push("cycling","biking", "bicycle", "bike", "mtb", "mountain")
      end
      if (this_amenity.disc_golf == 1)
        tags.push("disc_golf","disc golf","frisbee")
      end
      if (this_amenity.dog_friendly == 1)
        tags.push("dog_friendly","dog friendly", "off-leash", "dog", "dogs")
      end
      if (this_amenity.dog_leash == 1)
        tags.push("dog_leash","dog leash", "dog", "dogs")
      end
      if (this_amenity.drone == 1)
        tags.push("drone","drone flying")
      end
      if (this_amenity.ecological == 1)
        tags.push("ecological")
      end
      if (this_amenity.equestrian == 1)
        tags.push("equestrian","horse riding", "horse")
      end
      if (this_amenity.fishing == 1)
        tags.push("fishing")
      end
      if (this_amenity.ice_fishing == 1)
        tags.push("ice_fishing", "ice fishing")
      end
      if (this_amenity.golf == 1)
        tags.push("golf", "golfing")
      end
      if (this_amenity.hiking == 1)
        tags.push("hiking","walking", "running", "hike", "walk", "run", "jog", "jogging")
      end
      if (this_amenity.indoor_rental == 1)
        tags.push("indoor_rental","wedding", "meeting")
      end
      if (this_amenity.m_airplane == 1)
        tags.push("m_airplane","model airplane flying")
      end
      if (this_amenity.m_boat == 1)
        tags.push("m_boat","model boat")
      end
      if (this_amenity.nature_center == 1)
        tags.push("nature_center", "nature center", "museum", "education")
      end
      if (this_amenity.no_alcohol == 1)
        tags.push("no_alcohol")
      end
      if (this_amenity.no_parking == 1)
        tags.push("no_parking")
      end
      if (this_amenity.overlook == 1)
        tags.push("overlook")
      end
      if (this_amenity.pavillion == 1)
        tags.push("pavillion")
      end
      if ( (this_amenity.picnic_grove == 1) or (this_amenity.shelter == 1) )
        tags.push("picnic_grove","shelter", "picnic", "event space", "grove", "bbq", "grill")
      end
      if (this_amenity.skating_ice == 1)
        tags.push("skating_ice", "ice skating", "ice skate")
      end
      if (this_amenity.sledding == 1)
        tags.push("sledding","sled", "coasting")
      end
      if (this_amenity.snowmobile == 1)
        tags.push("snowmobile","snowmachine")
      end
      if (this_amenity.swimming == 1)
        tags.push("swimming","swim", "pool", "aquatic")
      end
      if (this_amenity.volunteer == 1)
        tags.push("volunteer","volunteering", "restoration")
      end
      if (this_amenity.zip_line == 1)
        tags.push("zip_line","zip line", "treetop adventure")
      end
      tags = tags.uniq
      p tags
      tags
    end

  end

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
