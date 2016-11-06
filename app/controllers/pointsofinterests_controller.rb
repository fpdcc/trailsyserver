class PointsofinterestsController < ApplicationController
  before_action :set_pointsofinterest, only: [:show, :edit, :update, :destroy]

  after_action :set_pointsofinterests_cache_key , only: [:destroy, :update, :upload]
  after_action :expire_this_json, only: [:destroy, :update, :upload]

  max_updated_at = Pointsofinterest.maximum(:updated_at).try(:utc).try(:to_s, :number)
  @@pointsofinterests_cache_key = "pointsofinterests/all-#{max_updated_at}"


  # GET /pointsofinterests
  # GET /pointsofinterests.json
  def index
    respond_to do |format|
      format.html do 
        authenticate_user!
        @pointsofinterests = Pointsofinterest.order("poi_info_id")
      end
      format.json do
        @pointsofinterests = Pointsofinterest.web_poi
        fresh_when last_modified: @pointsofinterests.maximum(:updated_at)
        #@pointsofinterests = cached_where_web_poi
        #@pointsofinterests = PoiInfo.where(web_poi: 'y')
        # if (params[:loc])
        #   @trailheads = sort_by_distance(@trailheads)
        # end
        #if stale?(@pointsofinterests)
        #fresh_when last_modified: @trailheads.maximum(:updated_at)
        
        entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        
        features = []
        @pointsofinterests.each do |pointsofinterest|
            json_attributes = create_json_attributes(pointsofinterest)
            feature = entity_factory.feature(pointsofinterest.geom_web, 
             pointsofinterest.id, 
             json_attributes)
            features.push(feature)
        end
        collection = entity_factory.feature_collection(features)
        my_geojson = RGeo::GeoJSON::encode(collection)
        ojDump = Oj.dump(my_geojson)
        if stale?(ojDump, public: true)
          render json: ojDump
          cache_page(@response, "/pointsofinterests.json")
        end
      end
    end
  end


  # GET /pointsofinterests/1
  # GET /pointsofinterests/1.json
  def show
  end

  # GET /pointsofinterests/new
  def new
    @pointsofinterest = Pointsofinterest.new
  end

  # GET /pointsofinterests/1/edit
  def edit
  end

  # POST /pointsofinterests
  # POST /pointsofinterests.json
  def create
    @pointsofinterest = Pointsofinterest.new(pointsofinterest_params)

    respond_to do |format|
      if @pointsofinterest.save
        format.html { redirect_to @pointsofinterest, notice: 'Pointsofinterest was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pointsofinterest }
      else
        format.html { render action: 'new' }
        format.json { render json: @pointsofinterest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pointsofinterests/1
  # PATCH/PUT /pointsofinterests/1.json
  def update
    respond_to do |format|
      if @pointsofinterest.update(pointsofinterest_params)
        format.html { redirect_to @pointsofinterest, notice: 'Pointsofinterest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pointsofinterest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pointsofinterests/1
  # DELETE /pointsofinterests/1.json
  def destroy
    @pointsofinterest.destroy
    respond_to do |format|
      format.html { redirect_to pointsofinterests_url }
      format.json { head :no_content }
    end
  end

  def create_json_attributes(pointsofinterest)
    json_attributes = pointsofinterest.attributes.except('geom', 'created_at', 'updated_at', 'latitude', 'longitude', 'addr', 'zip', 'zipmuni', 'municipality', 'zone_name','zonemapno', 'dwmapno','name','alt_name','alt2_name', 'web_poi', 'commdist')
   
    json_attributes["id"] = pointsofinterest.poi_info_id
    json_attributes["name"] = pointsofinterest.name
    alt_names = []
    if (pointsofinterest.alt_name)
      alt_names = alt_names.push(pointsofinterest.alt_name)
    end
    if (pointsofinterest.alt2_name)
      alt_names = alt_names.push(pointsofinterest.alt2_name)
    end
    if (alt_names.present?)
      json_attributes["alt_names"] = alt_names
    end
    if (pointsofinterest.activities)
      json_attributes["activities"] = pointsofinterest.activities.pluck('activities_id')
    end
    if (pointsofinterest.tags)
      json_attributes["tags"] = pointsofinterest.tags
    end
    this_poi_desc = pointsofinterest.poi_desc
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
      if (this_poi_desc.photo_link?)
        json_attributes["photo_link"] = this_poi_desc.photo_link
      end
      if (this_poi_desc.special_description?)
        json_attributes["special_description"] = this_poi_desc.special_description
      end
    end
    if pointsofinterest.has_trail_access
      this_trails_info = pointsofinterest.trails_infos.limit(1)[0]
      if this_trails_info
        json_attributes["direct_trail_id"] = this_trails_info.trail_subsystem + "-" + this_trails_info.trail_color + "-" + this_trails_info.trail_type
        json_attributes["trail_subsystem"] = this_trails_info.trail_subsystem
      end
    end
    json_attributes
  end

  private

    def expire_this_json
      expire_page("/pointsofinterests.json")
    end

    def set_pointsofinterests_cache_key
      max_updated_at = Pointsofinterest.maximum(:updated_at).try(:utc).try(:to_s, :number)
      @@pointsofinterests_cache_key = "pointsofinterests/all-#{max_updated_at}"
      puts "NEW pointsofinterests_cache_key: #{@@pointsofinterests_cache_key}"
    end  

    def cached_where_web_poi
      puts @@pointsofinterests_cache_key
      if @@pointsofinterests_cache_key.blank?
        pointsofinterests_cache_key
        puts "Initial PoiInfo cache key is: #{@@pointsofinterests_cache_key}"
      end
      Rails.cache.fetch("#{@@pointsofinterests_cache_key}/pointsofinterests", expires_in: 12.hour) do
        Pointsofinterest.includes(:poi_desc, :activities).where(web_poi: 'y')
        # last_update = @trailheads.maximum(:updated_at)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_pointsofinterest
      @pointsofinterest = Pointsofinterest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pointsofinterest_params
      params.require(:pointsofinterest).permit(:pointsofinterest_id, :geom)
    end
end