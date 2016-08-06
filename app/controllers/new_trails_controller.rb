class NewTrailsController < ApplicationController
  before_action :set_new_trail, only: [:show, :edit, :update, :destroy]
  after_action :expire_this_json, only: [:destroy, :update, :upload]

  # GET /new_trails
  # GET /new_trails.json
  # def index
  #   @new_trails = NewTrail.all
  # end

   def index
    respond_to do |format|
      format.html do 
        authenticate_user!
        @new_trails = NewTrail.all
      end
      format.json do
        #@trailheads = cached_all_by_name
        @new_trails = NewTrail.joins(:trails_info).select(:trails_id, :geom, :'trails_infos.web_trail', :'trails_infos.trail_subsystem', :'trails_infos.trail_color', :'trails_infos.trail_type', :'trails_infos.off_fpdcc')
        # if (params[:loc])
        #   @trailheads = sort_by_distance(@trailheads)
        # end
        #if stale?(@trailheads)
        #fresh_when last_modified: @trailheads.maximum(:updated_at)
        
        entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        
        features = []
        @new_trails.each do |new_trail|
          json_attributes = create_json_attributes(new_trail)
          feature = entity_factory.feature(new_trail.geom, 
           new_trail.id, 
           json_attributes)
          features.push(feature)
        end
        collection = entity_factory.feature_collection(features)
        my_geojson = RGeo::GeoJSON::encode(collection)
        ojDump = Oj.dump(my_geojson)
        #if stale?(ojDump, public: true)
          render json: ojDump
          cache_page(@response, "/new_trails.json")
        #end
      end
    end
  end

  # GET /new_trails/1
  # GET /new_trails/1.json
  def show
  end

  # GET /new_trails/new
  def new
    @new_trail = NewTrail.new
  end

  # GET /new_trails/1/edit
  def edit
  end

  # POST /new_trails
  # POST /new_trails.json
  def create
    @new_trail = NewTrail.new(new_trail_params)

    respond_to do |format|
      if @new_trail.save
        format.html { redirect_to @new_trail, notice: 'New trail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @new_trail }
      else
        format.html { render action: 'new' }
        format.json { render json: @new_trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /new_trails/1
  # PATCH/PUT /new_trails/1.json
  def update
    respond_to do |format|
      if @new_trail.update(new_trail_params)
        format.html { redirect_to @new_trail, notice: 'New trail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @new_trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /new_trails/1
  # DELETE /new_trails/1.json
  def destroy
    @new_trail.destroy
    respond_to do |format|
      format.html { redirect_to new_trails_url }
      format.json { head :no_content }
    end
  end

  def create_json_attributes(new_trail)
    json_attributes = new_trail.attributes.except('created_at', 'updated_at', 'geom')
  
    json_attributes
  end

  private
    def expire_this_json
      expire_page("/new_trails.json")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_new_trail
      @new_trail = NewTrail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_trail_params
      params.require(:new_trail).permit(:trails_id, :geom)
    end
end
