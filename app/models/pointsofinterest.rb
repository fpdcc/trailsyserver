class Pointsofinterest < ActiveRecord::Base
  self.primary_key = 'poi_info_id'
  has_one :poi_desc, foreign_key: :poi_info_id, primary_key: :poi_info_id
  has_many :activities, foreign_key: :poi_info_id, primary_key: :poi_info_id
  has_many :picnicgroves, foreign_key: :poi_info_id, primary_key: :poi_info_id
  has_many :poi_to_trails, foreign_key: :poi_info_id, primary_key: :poi_info_id
  has_many :trails_infos, through: :poi_to_trails

  scope :web_poi, -> { includes(:poi_desc, :activities).where(web_poi: 'y') }

  def geom_web
    if ( (parking_info_id.present?) && (parking_info_id > 0) )
      return ParkingEntranceInfo.find(parking_info_id).parking_entrance.geom;
    else
      return Pointsofinterest.find(poi_info_id).geom;
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

  def parking_connection_poi
    if self.parking_connection_id.present?
      parking_connection_pois = Pointsofinterest.where(parking_info_id: self.parking_connection_id)
      if parking_connection_pois.present?
        return parking_connection_pois.first
      end
    end
  end

  # def direct_trail_ids  
  # end

  def tags
    tags = {}
    panelTags = [];
    searchTags = [];
      if (bike_rental == 1)
        panelTags.push("bike_rental")
        searchTags.push("bike rental", "bicycle rental")
      end
      if (birding == 1)
        panelTags.push("birding")
        searchTags.push("birdwatching", "bird")
      end
      if (boat_ramp == 1)
        panelTags.push("boat_ramp")
      end
      if (canoe == 1)
        panelTags.push("canoe")
      end
      if (boat_rental == 1)
        panelTags.push("boat_rental")
        searchTags.push("boat_rental", "boat rental", "canoe rental", "kayak rental", "boating center")
      end
      if ( (boat_ramp == 1) or (canoe == 1) or (boat_rental == 1) )
        searchTags.push("canoe", "boat_ramp", "boat ramp", "canoeing", "kayaking", "boating", "kayak", "boat")
      end
      if (camping == 1)
        panelTags.push("camping")
        searchTags.push("camp","campground")
      end
      if (cross_country == 1)
        panelTags.push("cross_country")
        searchTags.push("cross-country skiing","ski")
      end
      if (cycling == 1)
        panelTags.push("cycling")
        searchTags.push("biking", "bicycle", "bike", "mtb", "mountain")
      end
      if (disc_golf == 1)
        panelTags.push("disc_golf")
        searchTags.push("disc golf","frisbee")
      end
      if (dog_friendly == 1)
        panelTags.push("dog_friendly")
        searchTags.push("dog friendly", "off-leash", "dog", "dogs")
      end
      if (dog_leash == 1)
        panelTags.push("dog_leash")
        searchTags.push("dog leash", "dog", "dogs")
      end
      if (driving_range == 1)
        panelTags.push("driving_range")
      end
      if (drone == 1)
        panelTags.push("drone")
        searchTags.push("drone flying")
      end
      if (equestrian == 1)
        panelTags.push("equestrian")
        searchTags.push("horse riding", "horse")
      end
      if (fishing == 1)
        panelTags.push("fishing")
      end
      # if (no_fishing == 1)
      #   panelTags.push("no_fishing")
      # end
      if (ice_fishing == 1)
        panelTags.push("ice_fishing")
        searchTags.push("ice fishing")
      end
      if (golf == 1)
        panelTags.push("golf")
        searchTags.push("golfing")
      end
      if (hiking == 1)
        panelTags.push("hiking")
        searchTags.push("walking", "running", "hike", "walk", "run", "jog", "jogging")
      end
      if (indoor_rental == 1)
        panelTags.push("indoor_rental")
        searchTags.push("wedding", "meeting")
      end
      if (m_airplane == 1)
        panelTags.push("m_airplane")
        searchTags.push("model airplane flying")
      end
      if (m_boat == 1)
        panelTags.push("m_boat")
        searchTags.push("model boat")
      end
      if (nature_center == 1)
        panelTags.push("nature_center")
        searchTags.push("nature center", "museum", "education")
      end
      if (nature_preserve == 1)
        panelTags.push("nature_preserve")
      end
      if (no_alcohol == 1)
        panelTags.push("no_alcohol")
      end
      if (no_parking == 1)
        panelTags.push("no_parking")
      end
      if (no_parking == 0)
        panelTags.push("parking")
      end
      if (overlook == 1)
        panelTags.push("overlook")
      end
      # if (pavillion == 1)
      #   panelTags.push("pavillion")
      # end
      if (picnic_grove == 1)
        panelTags.push("picnic_grove")
      end
      if (public_building == 1)
        panelTags.push("public_building")
      end
      if (shelter == 1)
        panelTags.push("shelter")
      end
      if ( (picnic_grove == 1) or (shelter == 1) )
        searchTags.push("picnic_grove","shelter", "picnic", "event space", "grove", "bbq", "grill")
      end
      if (skating_ice == 1)
        panelTags.push("skating_ice")
        searchTags.push("ice skating", "ice skate")
      end
      if (sledding == 1)
        panelTags.push("sledding")
        searchTags.push("sled", "coasting")
      end
      if (snowmobile == 1)
        panelTags.push("snowmobile")
        searchTags.push("snowmachine")
      end
      if (swimming == 1)
        panelTags.push("swimming")
        searchTags.push("swim", "pool", "aquatic")
      end
      if (volunteer == 1)
        panelTags.push("volunteer")
        searchTags.push("volunteering", "restoration")
      end
      if (zip_line == 1)
        panelTags.push("zip_line")
        searchTags.push("zip line", "treetop adventure")
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
	      new_item = Pointsofinterest.new
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
