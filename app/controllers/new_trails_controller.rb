class NewTrailsController < ApplicationController
  before_action :set_new_trail, only: [:show, :edit, :update, :destroy]
  after_action :expire_this_json, only: [:destroy, :update, :upload]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /new_trails
  # GET /new_trails.json
  # def index
  #   @new_trails = NewTrail.all
  # end

   def index
    respond_to do |format|
      format.html do 
        authenticate_user!
        @new_trails = NewTrail.all.paginate(page: params[:page])
      end
      format.json do
        #@trailheads = cached_all_by_name
        simplify_factor = params[:simplify].to_i
        logger.info "simplify param = #{simplify_factor}"
        # if simplify_factor > 0
        #   @new_trails = NewTrail.joins(:trails_info).find_by_sql(["select *, st_linemerge(geom::geometry) as merged_geom from new_trails"]);
        # else
        @new_trails = NewTrail.joins(:trails_info).select(:trails_id, :geom, :'trails_infos.web_trail', :'trails_infos.trail_subsystem', :'trails_infos.trail_color', :'trails_infos.trail_type', :'trails_infos.off_fpdcc', :'trails_infos.direction', :'trails_infos.segment_type')
        # end
        # if (params[:loc])
        #   @trailheads = sort_by_distance(@trailheads)
        # end
        #if stale?(@trailheads)
        #fresh_when last_modified: @trailheads.maximum(:updated_at)
        
        entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        line_factory = ::RGeo::Geographic.spherical_factory(:srid => 4326)
        
        features = []
        # @new_trails.each do |new_trail|
        #   json_attributes = create_json_attributes(new_trail)
        #   feature = entity_factory.feature(new_trail.geom, 
        #    new_trail.id, 
        #    json_attributes)
        #   features.push(feature)
        # end

        @new_trails.each do |new_trail|
          merged_geom = new_trail.attributes["geom"]
          if simplify_factor > 0
            logger.info "simplify factor = #{simplify_factor}"
            if merged_geom.geometry_type.type_name == "MultiLineString" # for multilinestrings we need to loop through contained linestrings
              logger.info "is MultiLineString"
              new_new_trail_linestrings = []
              merged_geom.each_with_index do |linestring, ls_index|
                new_linestring_points = []
                linestring.points.each_with_index do |point, p_index| # and then loop through the points in each linestring
                  if p_index % simplify_factor == 0 || p_index == linestring.num_points - 1
                    new_linestring_points.push(point)
                  end
                end
                new_new_trail_linestrings.push(line_factory.line_string(new_linestring_points))
              end
              simplified_new_trail_geom = line_factory.multi_line_string(new_new_trail_linestrings)
              new_trail.geom = simplified_new_trail_geom

            elsif merged_geom.geometry_type.type_name == "LineString" # for linestrings we can just loop through the points
              logger.info "is LineString"
              new_linestring_points = []
              merged_geom.points.each_with_index do |point, p_index|
                if p_index % simplify_factor == 0 || p_index == merged_geom.num_points() - 1
                  new_linestring_points.push(point)
                end
              end
              simplified_new_trail_geom = line_factory.line_string(new_linestring_points)
              new_trail.geom = simplified_new_trail_geom
            end
          end
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
    json_attributes['trail_subsystem'] = new_trail.trail_subsystem.strip
  
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
