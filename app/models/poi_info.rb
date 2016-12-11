class PoiInfo < ActiveRecord::Base
	self.primary_key = 'poi_info_id'
	
	has_one :poi_desc, foreign_key: :poi_info_id, primary_key: :poi_info_id
	has_one :poi_amenity, foreign_key: :poi_info_id, primary_key: :poi_info_id
	has_many :activities, foreign_key: :poi_info_id, primary_key: :poi_info_id
  has_many :picnicgroves, foreign_key: :poi_info_id, primary_key: :poi_info_id
	has_one :name, foreign_key: :nameid, primary_key: :nameid
	has_one :name_alt1, class_name: 'Name', foreign_key: :nameid, primary_key: :alt_nameid
	has_one :name_alt2, class_name: 'Name', foreign_key: :nameid, primary_key: :alt2_nameid

  scope :web_poi, -> { includes(:name, :poi_desc, :activities).where(web_poi: 'y') }

  def geom
    if ( (parking_info_id.present?) && (parking_info_id > 0) )
      #p "Parking Info Present."
      return ParkingEntranceInfo.find(parking_info_id).parking_entrance.geom;
    else
      #p "Parking Info Not Present."
      return Pointsofinterest.find(pointsofinterest_id).geom;
    end
  end

  def trail_subsystems
    this_trails_infos = self.trails_infos
    trail_subsystems = this_trails_infos.pluck('trail_subsystem').uniq
  end

  def has_trail_access
    this_trailheads = self.activities.where(atype: "trailhead")
    if this_trailheads.length > 0
      return true
    end
    return false
  end


  # def direct_trail_ids  
  # end

  def tags
    this_amenity = self.poi_amenity
    tags = {}
    panelTags = [];
    searchTags = [];
    if (this_amenity)
      if (this_amenity.bike_rental == 1)
        panelTags.push("bike_rental")
        searchTags.push("bike rental", "bicycle rental")
      end
      if (this_amenity.birding == 1)
        panelTags.push("birding")
        searchTags.push("birdwatching", "bird")
      end
      if (this_amenity.boat_ramp == 1)
        panelTags.push("boat_ramp")
      end
      if (this_amenity.canoe == 1)
        panelTags.push("canoe")
      end
      if (this_amenity.boat_rental == 1)
        panelTags.push("boat_rental")
      end
      if ( (this_amenity.boat_ramp == 1) or (this_amenity.canoe == 1) or (this_amenity.boat_rental == 1) )
        searchTags.push("boat_rental","boat rental", "canoe", "boat_ramp", "boat ramp", "canoe rental", "kayak rental", "boating center", "canoeing", "kayaking", "boating", "kayak", "boat")
      end
      if (this_amenity.camping == 1)
        panelTags.push("camping")
        searchTags.push("camp","campground")
      end
      if (this_amenity.cross_country == 1)
        panelTags.push("cross_country")
        searchTags.push("cross-country skiing","ski")
      end
      if (this_amenity.cycling == 1)
        panelTags.push("cycling")
        searchTags.push("biking", "bicycle", "bike", "mtb", "mountain")
      end
      if (this_amenity.disc_golf == 1)
        panelTags.push("disc_golf")
        searchTags.push("disc golf","frisbee")
      end
      if (this_amenity.dog_friendly == 1)
        panelTags.push("dog_friendly")
        searchTags.push("dog friendly", "off-leash", "dog", "dogs")
      end
      if (this_amenity.dog_leash == 1)
        panelTags.push("dog_leash")
        searchTags.push("dog leash", "dog", "dogs")
      end
      if (this_amenity.driving_range == 1)
        panelTags.push("driving_range")
      end
      if (this_amenity.drone == 1)
        panelTags.push("drone")
        searchTags.push("drone flying")
      end
      if (this_amenity.equestrian == 1)
        panelTags.push("equestrian")
        searchTags.push("horse riding", "horse")
      end
      if (this_amenity.fishing == 1)
        panelTags.push("fishing")
      end
      # if (this_amenity.no_fishing == 1)
      #   panelTags.push("no_fishing")
      # end
      if (this_amenity.ice_fishing == 1)
        panelTags.push("ice_fishing")
        searchTags.push("ice fishing")
      end
      if (this_amenity.golf == 1)
        panelTags.push("golf")
        searchTags.push("golfing")
      end
      if (this_amenity.hiking == 1)
        panelTags.push("hiking")
        searchTags.push("walking", "running", "hike", "walk", "run", "jog", "jogging")
      end
      if (this_amenity.indoor_rental == 1)
        panelTags.push("indoor_rental")
        searchTags.push("wedding", "meeting")
      end
      if (this_amenity.m_airplane == 1)
        panelTags.push("m_airplane")
        searchTags.push("model airplane flying")
      end
      if (this_amenity.m_boat == 1)
        panelTags.push("m_boat")
        searchTags.push("model boat")
      end
      if (this_amenity.nature_center == 1)
        panelTags.push("nature_center")
        searchTags.push("nature center", "museum", "education")
      end
      if (this_amenity.nature_preserve == 1)
        panelTags.push("nature_preserve")
      end
      if (this_amenity.no_alcohol == 1)
        panelTags.push("no_alcohol")
      end
      if (this_amenity.no_parking == 1)
        panelTags.push("no_parking")
      end
      if (this_amenity.no_parking == 0)
        panelTags.push("parking")
      end
      if (this_amenity.overlook == 1)
        panelTags.push("overlook")
      end
      if (this_amenity.pavillion == 1)
        panelTags.push("pavillion")
      end
      if (this_amenity.picnic_grove == 1)
        panelTags.push("picnic_grove")
      end
      if (this_amenity.public_building == 1)
        panelTags.push("public_building")
      end
      if (this_amenity.shelter == 1)
        panelTags.push("shelter")
      end
      if ( (this_amenity.picnic_grove == 1) or (this_amenity.shelter == 1) )
        searchTags.push("picnic_grove","shelter", "picnic", "event space", "grove", "bbq", "grill")
      end
      if (this_amenity.skating_ice == 1)
        panelTags.push("skating_ice")
        searchTags.push("ice skating", "ice skate")
      end
      if (this_amenity.sledding == 1)
        panelTags.push("sledding")
        searchTags.push("sled", "coasting")
      end
      if (this_amenity.snowmobile == 1)
        panelTags.push("snowmobile")
        searchTags.push("snowmachine")
      end
      if (this_amenity.swimming == 1)
        panelTags.push("swimming")
        searchTags.push("swim", "pool", "aquatic")
      end
      if (this_amenity.volunteer == 1)
        panelTags.push("volunteer")
        searchTags.push("volunteering", "restoration")
      end
      if (this_amenity.zip_line == 1)
        panelTags.push("zip_line")
        searchTags.push("zip line", "treetop adventure")
      end
    end
    if (self.has_trail_access)
      panelTags.push("trailhead")
    end
    panelTags = panelTags.uniq
    searchTags = searchTags.uniq
    tags = {panel: panelTags, search: searchTags}
    #p tags
    tags
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
