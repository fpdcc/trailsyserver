class PoiInfosController < ApplicationController
  before_action :set_poi_info, only: [:show, :edit, :update, :destroy]

  after_action :set_poi_infos_cache_key , only: [:destroy, :update, :upload]
  after_action :expire_this_json, only: [:destroy, :update, :upload]

  max_updated_at = PoiInfo.maximum(:updated_at).try(:utc).try(:to_s, :number)
  @@poi_infos_cache_key = "poi_infos/all-#{max_updated_at}"

  # GET /poi_infos
  # GET /poi_infos.json
  # def index
  #   @poi_infos = PoiInfo.all
  # end

  def index
    respond_to do |format|
      format.html do 
        authenticate_user!
        @poi_infos = PoiInfo.order("poi_info_id")
      end
      format.json do

        @poi_infos = PoiInfo.web_poi
        fresh_when last_modified: @poi_infos.maximum(:updated_at)
        #@poi_infos = cached_where_web_poi
        #@poi_infos = PoiInfo.where(web_poi: 'y')
        # if (params[:loc])
        #   @trailheads = sort_by_distance(@trailheads)
        # end
        #if stale?(@poi_infos)
        #fresh_when last_modified: @trailheads.maximum(:updated_at)
        
        entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        
        features = []
        @poi_infos.each do |poi_info|
            json_attributes = create_json_attributes(poi_info)
            feature = entity_factory.feature(poi_info.geom, 
             poi_info.id, 
             json_attributes)
            features.push(feature)
        end
        collection = entity_factory.feature_collection(features)
        my_geojson = RGeo::GeoJSON::encode(collection)
        ojDump = Oj.dump(my_geojson)
        if stale?(ojDump, public: true)
        #cache ojDump
          render json: ojDump
          cache_page(@response, "/poi_infos.json")
        end
      end
    end
  end

  # GET /poi_infos/1
  # GET /poi_infos/1.json
  def show
  end

  # GET /poi_infos/new
  def new
    @poi_info = PoiInfo.new
  end

  # GET /poi_infos/1/edit
  def edit
  end

  # POST /poi_infos
  # POST /poi_infos.json
  def create
    @poi_info = PoiInfo.new(poi_info_params)

    respond_to do |format|
      if @poi_info.save
        format.html { redirect_to @poi_info, notice: 'Poi info was successfully created.' }
        format.json { render action: 'show', status: :created, location: @poi_info }
      else
        format.html { render action: 'new' }
        format.json { render json: @poi_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poi_infos/1
  # PATCH/PUT /poi_infos/1.json
  def update
    respond_to do |format|
      if @poi_info.update(poi_info_params)
        format.html { redirect_to @poi_info, notice: 'Poi info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poi_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poi_infos/1
  # DELETE /poi_infos/1.json
  def destroy
    @poi_info.destroy
    respond_to do |format|
      format.html { redirect_to poi_infos_url }
      format.json { head :no_content }
    end
  end

  def create_json_attributes(poi_info)
    json_attributes = poi_info.attributes.except('created_at', 'updated_at', 'latitude', 'longitude', 'addr', 'zip', 'zipmuni', 'municipality', 'zone_name','zonemapno', 'dwmapno','nameid','alt_nameid','alt2_nameid', 'web_poi', 'commdist')
   
    json_attributes["id"] = poi_info.poi_info_id
    json_attributes["name"] = poi_info.name.name
    alt_names = []
    if (poi_info.name_alt1)
      alt_names = alt_names.push(poi_info.name_alt1.name)
    end
    if (poi_info.name_alt2)
      alt_names = alt_names.push(poi_info.name_alt2.name)
    end
    if (alt_names.present?)
      json_attributes["alt_names"] = alt_names
    end
    if (poi_info.activities)
      json_attributes["activities"] = poi_info.activities.pluck('activities_id')
    end
    if (poi_info.tags)
      json_attributes["tags"] = poi_info.tags
    end
    this_poi_desc = poi_info.poi_desc
    if (this_poi_desc)
      if (this_poi_desc.hours1?)
        json_attributes["hours1"] = this_poi_desc.hours1
      end
      if (this_poi_desc.hours2?)
        json_attributes["hours2"] = this_poi_desc.hours2
      end
      if (this_poi_desc.phone?)
        json_attributes["phone"] = this_poi_desc.phone
      end
      if (this_poi_desc.season1?)
        json_attributes["season1"] = this_poi_desc.season1
      end
      if (this_poi_desc.season2?)
        json_attributes["season2"] = this_poi_desc.season2
      end
      if (this_poi_desc.description?)
        json_attributes["description"] = this_poi_desc.description
      end
      if (this_poi_desc.web_link?)
        json_attributes["web_link"] = this_poi_desc.web_link
      end
      if (this_poi_desc.map_link?)
        json_attributes["map_link"] = this_poi_desc.map_link
      end
      if (this_poi_desc.map_link_spanish?)
        json_attributes["map_link_spanish"] = this_poi_desc.map_link_spanish
      end
      if (this_poi_desc.vol_link?)
        json_attributes["vol_link"] = this_poi_desc.vol_link
      end
      if (this_poi_desc.vol_link2?)
        json_attributes["vol_link2"] = this_poi_desc.vol_link2
      end
      if (this_poi_desc.picnic_link?)
        json_attributes["picnic_link"] = this_poi_desc.picnic_link
      end
      if (this_poi_desc.event_link?)
        json_attributes["event_link"] = this_poi_desc.event_link
      end
      if (this_poi_desc.custom_link?)
        json_attributes["custom_link"] = this_poi_desc.custom_link
      end
      if (this_poi_desc.special_hours?)
        json_attributes["special_hours"] = this_poi_desc.special_hours
      end
      if (this_poi_desc.special_link?)
        json_attributes["special_link"] = this_poi_desc.special_link
      end
      if (this_poi_desc.special_description?)
        json_attributes["special_description"] = this_poi_desc.special_description
      end
    end
    if poi_info.has_trail_access
      this_trails_info = poi_info.trails_infos.limit(1)[0]
      if this_trails_info
        json_attributes["direct_trail_id"] = this_trails_info.trail_subsystem + "-" + this_trails_info.trail_color + "-" + this_trails_info.trail_type
        json_attributes["trail_subsystem"] = this_trails_info.trail_subsystem
      end
    end
    


    json_attributes
  end

  private

    def expire_this_json
      expire_page("/poi_infos.json")
    end

    def set_poi_infos_cache_key
      max_updated_at = PoiInfo.maximum(:updated_at).try(:utc).try(:to_s, :number)
      @@poi_infos_cache_key = "poi_infos/all-#{max_updated_at}"
      puts "NEW poi_infos_cache_key: #{@@poi_infos_cache_key}"
    end  

    def cached_where_web_poi
        puts @@poi_infos_cache_key
      if @@poi_infos_cache_key.blank?
        poi_infos_cache_key
        puts "Initial PoiInfo cache key is: #{@@poi_infos_cache_key}"
      end
      Rails.cache.fetch("#{@@poi_infos_cache_key}/poi_infos", expires_in: 12.hour) do
        PoiInfo.includes(:name, :poi_desc, :activities).where(web_poi: 'y')
        # last_update = @trailheads.maximum(:updated_at)
      end
    
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_poi_info
      @poi_info = PoiInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poi_info_params
      params.require(:poi_info).permit(:poi_info_id, :point_type, :addr, :zip, :zipmuni, :municipality, :public_access, :latitude, :longitude, :commdist, :zone_name, :zonemapno, :dwmapno, :nameid, :pointsofinterest_id, :fpd_uid, :web_poi, :web_street_addr, :web_muni_addr, :parking_connection_id, :parking_info_id, :alt_nameid, :alt2_nameid)
    end
end


