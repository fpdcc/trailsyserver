class TrailsInfosController < ApplicationController
  before_action :set_trails_info, only: [:show, :edit, :update, :destroy]
  after_action :expire_this_json, only: [:destroy, :update, :upload]
  before_action :authenticate_user!, except: [:index, :show]
  caches_page :index, gzip: true, except: -> { request.format.html? }
 
  # GET /trails_infos
  # GET /trails_infos.json
  # def index
  #   @trails_infos = TrailsInfo.all
  # end

  def index
    respond_to do |format|
      format.html do 
        authenticate_user!
        authorize TrailsInfo
        @trails_infos = TrailsInfo.order(:trail_system, :trail_subsystem, :trail_color, :trail_type, :alt_name).paginate(page: params[:page])

      end
      format.json do
        @trails = TrailsInfo.select(:id, :direct_trail_id, :geom)
        entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        line_factory = ::RGeo::Geographic.spherical_factory(:srid => 4326)
        
        features = []
        @trails.each do |trail|
          merged_geom = trail.attributes["geom"]
          json_attributes = create_json_attributes(trail)
          feature = entity_factory.feature(trail.geom, 
            trail.trail_info_id, 
            json_attributes)
          features.push(feature)
        end

        collection = entity_factory.feature_collection(features)
        my_geojson = RGeo::GeoJSON::encode(collection)
        ojDump = Oj.dump(my_geojson)
        #if stale?(ojDump, public: true)
          render json: ojDump
          #cache_page(@response, "/trails_infos.json")
        #end
      end
    end
  end

  # GET /trails_infos/1
  # GET /trails_infos/1.json
  def show
    authorize @trails_info
  end

  # GET /trails_infos/new
  def new
    @trails_info = TrailsInfo.new
    authorize @trails_info
  end

  # GET /trails_infos/1/edit
  def edit
    authorize @trails_info
  end

  # POST /trails_infos
  # POST /trails_infos.json
  def create
    @trails_info = TrailsInfo.new(trails_info_params)
    authorize @trails_info
    respond_to do |format|
      if @trails_info.save
        format.html { redirect_to @trails_info, notice: 'Trails info was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trails_info }
      else
        format.html { render action: 'new' }
        format.json { render json: @trails_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trails_infos/1
  # PATCH/PUT /trails_infos/1.json
  def update
    authorize @trails_info
    respond_to do |format|
      if @trails_info.update(trails_info_params)
        format.html { redirect_to @trails_info, notice: 'Trails info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trails_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trails_infos/1
  # DELETE /trails_infos/1.json
  def destroy
    authorize @trails_info
    @trails_info.destroy
    respond_to do |format|
      format.html { redirect_to trails_infos_url }
      format.json { head :no_content }
    end
  end

  def create_json_attributes(trail)
    json_attributes = {}
    json_attributes["direct_trail_id"] = trail.direct_trail_id
    json_attributes
  end

  private

    def expire_this_json
      expire_page("/trails_infos.json")
      expire_page("/trails_infos.json.gz")
    end

    
    # Use callbacks to share common setup or constraints between actions.
    def set_trails_info
      @trails_info = TrailsInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trails_info_params
      params.require(:trails_info).permit(TrailsInfo.column_names - ["created_at", "updated_at"])
      #params.require(:trails_info).permit(:direct_trail_id, :direct_trail_name, :segment_type, :direction, :trail_system, :trail_subsystem, :trail_color, :trail_surface, :trail_type, :trail_difficulty, :regional_trail_name, :trail_desc, :gps, :comment, :alt_name, :cambr_name, :on_street, :crossing_type, :unrecognized, :length_mi, :trails_id, :off_fpdcc, :web_trail, :maintenance, :length_ft, :trail_info_id)
    end
end
