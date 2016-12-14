class TrailsInfosController < ApplicationController
  before_action :set_trails_info, only: [:show, :edit, :update, :destroy]
  after_action :expire_this_json, only: [:destroy, :update, :upload]
  before_action :authenticate_user!, except: [:index, :show]


  # GET /trails_infos
  # GET /trails_infos.json
  # def index
  #   @trails_infos = TrailsInfo.all
  # end

  def index
    respond_to do |format|
      format.html do 
        authenticate_user!
        @trails_infos = TrailsInfo.order(:trail_system, :trail_subsystem, :trail_color, :trail_type, :alt_name).paginate(page: params[:page])

      end
      format.json do
        #@trailheads = cached_all_by_name
        #@trails_infos = TrailsInfo.joins(:trails_desc).select(:trail_subsystem, :trail_color, :trail_type, trails_desc.traiL_desc_id).distinct
        
        @trails_infos = TrailsInfo.left_join(:trails_desc).select(:trail_subsystem, :trail_color, :trail_type, :off_fpdcc, :'trails_descs.trail_desc_id', :'trails_descs.map_link', :'trails_descs.map_link_spanish',:'trails_descs.trail_desc', :'trails_descs.alt_name').distinct.sort_by(&:subtrail_length_mi).reverse

        entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        
        features = []
        @trails_infos.each do |trails_info|

          json_attributes = create_json_attributes(trails_info)
          feature = entity_factory.feature(RGeo::Geographic.spherical_factory.point(0,0), 
           trails_info.id, 
           json_attributes)
          features.push(feature)
        end
        collection = entity_factory.feature_collection(features)
        my_geojson = RGeo::GeoJSON::encode(collection)
        ojDump = Oj.dump(my_geojson)
        #if stale?(ojDump, public: true)
          render json: ojDump
          cache_page(@response, "/trails_infos.json")
        #end
      end
    end
  end

  # GET /trails_infos/1
  # GET /trails_infos/1.json
  def show
  end

  # GET /trails_infos/new
  def new
    @trails_info = TrailsInfo.new
  end

  # GET /trails_infos/1/edit
  def edit
  end

  # POST /trails_infos
  # POST /trails_infos.json
  def create
    @trails_info = TrailsInfo.new(trails_info_params)

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
    @trails_info.destroy
    respond_to do |format|
      format.html { redirect_to trails_infos_url }
      format.json { head :no_content }
    end
  end

  def create_json_attributes(trails_info)
    json_attributes = trails_info.attributes.except('created_at', 'updated_at', 'trail_info_id')
    json_attributes["subtrail_length_mi"] = trails_info.subtrail_length_mi
    json_attributes["direct_trail_id"] = trails_info.trail_subsystem + "-" + trails_info.trail_color + "-" + trails_info.trail_type

    json_attributes
  end

  private

    def expire_this_json
      expire_page("/trails_infos.json")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_trails_info
      @trails_info = TrailsInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trails_info_params
      params.require(:trails_info).permit(:trail_system, :trail_subsystem, :trail_color, :trail_surface, :trail_type, :trail_difficulty, :regional_trail_name, :trail_desc, :gps, :comment, :alt_name, :cambr_name, :on_street, :crossing_type, :unrecognized, :length_mi, :trails_id, :off_fpdcc, :web_trail, :maintenance, :length_ft, :trail_info_id)
    end
end
