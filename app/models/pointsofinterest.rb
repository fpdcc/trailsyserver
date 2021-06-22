class Pointsofinterest < ApplicationRecord
  self.primary_key = 'poi_info_id'
  has_one :poi_desc, foreign_key: :poi_info_id, primary_key: :poi_info_id
  has_many :activities, foreign_key: :poi_info_id, primary_key: :poi_info_id
  has_many :trails_infos, through: :activities
  has_many :picnicgroves, foreign_key: :poi_info_id, primary_key: :poi_info_id
  
  has_many :alertings, :as => :alertable
  has_many :alerts, :through => :alertings

  has_many :current_alerts, -> { current }, :through => :alertings, :source => 'alert'
  has_many :future_alerts, -> { future }, :through => :alertings, :source => 'alert'

  accepts_nested_attributes_for :alerts
  accepts_nested_attributes_for :alertings
  
  # has_many :active_alertings, -> { active }, :as => :alertable
  # has_many :alerts, :through => :active_alertings

  include Alertable

  scope :web_poi, -> { includes(:poi_desc, :activities).where(web_poi: 'y') }
  scope :has_trail_access, -> { joins(:activities).where.not(activities: {trail_info_id: nil}) }
  scope :has_parking, -> { where("parking_info_id > 0") }
  scope :with_active_alerts, -> { references(:alerts).where('alerts.starts_at <= ? and (alerts.ends_at >= ? or alerts.ends_at is null)', Time.now, Time.now) }
  scope :no_active_alerts, -> { references(:alerts).where(
    "pointsofinterests.poi_info_id NOT IN (
    SELECT DISTINCT(alerts.alertable_id) 
    FROM alertings 
    where 
    alerts.alertable_type = 'Pointsofinterest'
    and
    alerts.starts_at <= ? 
    and 
    (alerts.ends_at >= ? or alerts.ends_at is null)
    )", Time.now, Time.now) }

  scope :no_current_or_future_alerts, -> { where(
    "pointsofinterests.poi_info_id NOT IN (
    SELECT DISTINCT(alertings.alertable_id) 
    FROM alertings, alerts
    where 
    alertings.alertable_type = 'Pointsofinterest'
    and
    alertings.alert_id = alerts.id
    and
    (alerts.ends_at >= ? or alerts.ends_at is null)
    )", Time.now).order('name asc')}

  scope :with_current_or_future_alerts,  ->  { references(:alerts).where('alerts.starts_at is not null and (alerts.ends_at >= ? or alerts.ends_at is null)', Time.now).order('name asc')}

  scope :id_and_name_only, -> { select(:id, :poi_info_id, :name)}

  # scope :with_quotes_count, -> do joins('LEFT OUTER JOIN quotes_themes on quotes_themes.theme_id = themes.id') .select('themes.*, COUNT(quotes_themes.quote_id) as quotes_count') .group('themes.id')end


  self.per_page = 60

  # ransacker :currentalertcount do
  #   Arel.sql('alert.starts_at <= ? and (alert.ends_at >= ? or alert.ends_at is null)', Time.now, Time.now)
  # end

  def geom_web
    if (web_map_geom.present?)
      return web_map_geom
    elsif ( (parking_info_id.present?) && (parking_info_id > 0) )
      return ParkingEntrance.find(parking_info_id).geom
    else
      return geom
    end
  end

  def web_link
    if self.poi_desc
      return self.poi_desc.web_link
    else
      return ""
    end
  end

  def map_id
    self.id + '-' + self.name
  end

  def type
    'poi'
  end

  def trail_subsystems
    this_trails_infos = self.trails_infos
    trail_subsystems = this_trails_infos.pluck('trail_subsystem').uniq
  end

  def self.maintenance_divs
    maintenance_divs = Pointsofinterest.all.pluck('maintenance_div').uniq.sort
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
  
  def has_trail_access    
    this_trailheads = self.activities.where.not(trail_info_id: nil)   
    if this_trailheads.length > 0   
      return true   
    end   
    return false    
  end

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
        searchTags.push("biking", "bicycle", 'bicycling', "bike", "mtb", "mountain")
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
      if (fitness_stairs == 1)
        panelTags.push("fitness_stairs")
        searchTags.push("fitness stairs")
      end
      if (fishing == 1)
        panelTags.push("fishing")
      end
      if (no_fishing == 1)
        panelTags.push("no_fishing")
      end
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
      if (pavilion == 1)
        panelTags.push("pavilion")
      end
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
      # bathroom section
      if (bathroom_building_winter == 1)
        panelTags.push("bathroom_building_winter")
      end
      if (bathroom_building_summer == 1)
        panelTags.push("bathroom_building_summer")
      end
      if (bathroom_building_ada == 1)
        panelTags.push("bathroom_building_ada")
      end
      if (bathroom_portable_winter == 1)
        panelTags.push("bathroom_portable_winter")
      end
      if (bathroom_portable_summer == 1)
        panelTags.push("bathroom_portable_summer")
      end
      if (bathroom_portable_ada == 1)
        panelTags.push("bathroom_portable_ada")
      end
      if (shower == 1)
        panelTags.push('shower')
      end
      if (sanitation_station == 1)
        panelTags.push('sanitation_station')
      end
      if (camp_store == 1)
        panelTags.push('camp_store')
      end
      if (natureplay == 1)
        panelTags.push('natureplay')
      end
      if (no_dogs == 1)
        panelTags.push('no_dogs')
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

  def self.parse_csv(contents)
      pois_to_update = []
      ids_in_csv = []
      CSV.parse(contents, headers: true, header_converters: :downcase) do |row|
        next if (row.to_s =~ /^source/)
        #logger.info "this row = #{row}"
        poi_item = Pointsofinterest.find_or_initialize_by(poi_info_id: row['poi_info_id'])
       
        ids_in_csv.push(row['poi_info_id'])
        poi_attrs = {}
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
          # Build poi Info Attrs
          if poi_item.attributes.has_key? header
            poi_attrs[header] = value
          else
            #p "Field not in trails_info_attrs: #{header}"
          end
          end
          # Determine adds + changes for trails_info
        poi_item.assign_attributes(poi_attrs)
        parsed_item = {}
        parsed_item['id'] = poi_item.id
        parsed_item['changes'] = poi_item.changes
        if poi_item.new_record?
          parsed_item['type'] = "Add"
          pois_to_update.push(parsed_item)
        elsif poi_item.changed?
          parsed_item['type'] = "Update"
          pois_to_update.push(parsed_item)
        end
      end

      ids_in_csv.uniq!
      Pointsofinterest.where.not(poi_info_id: ids_in_csv).find_each(batch_size: 20000) do |poi|
        parsed_item = {}
        parsed_item['id'] = poi.poi_info_id
        parsed_item['type'] = "Delete"
        pois_to_update.push(parsed_item)
      end
      return pois_to_update
  end

	def self.parse_csv_old(file)
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
	      end
	      parsed_items.push new_item
	    end
	    parsed_items
	end
end
