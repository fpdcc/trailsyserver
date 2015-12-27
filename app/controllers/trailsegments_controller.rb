class TrailsegmentsController < ApplicationController
  before_action :set_trailsegment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_show_all_param
  before_action :check_for_cancel, only: [:update]

  after_action :set_trailsegments_cache_key , only: [:destroy, :update, :upload]

  max_updated_at = Trailsegment.maximum(:updated_at).try(:utc).try(:to_s, :number)
  @@trailsegments_cache_key = "trails/all-#{max_updated_at}"
  
  # GET /trailsegments
  # GET /trailsegments.json
  # if "simplify" number parameter is supplied, get the ST_LineMerge version of the segment geometries, then
  # simplify all of the resulting LineStrings to include the first point, the last point, 
  # and every "simplify"th point in between. 
  # An attempt to simplify the data enough for Leaflet to work on iOS 7 MobileSafari.

  def index

    respond_to do |format|
      format.html do
        authenticate_user!
        if params[:all] == "true" || current_user.admin?
          @trailsegments = Trailsegment.order("trail1").order("trail2").order("trail3")
        else
          @trailsegments = Trailsegment.joins(:source).merge(Organization.where(id: current_user.organization)).order("trail1").order("trail2").order("trail3")
        end
      end
      format.json do
        trailID = params[:trail_id]
        simplify_factor = params[:simplify].to_i
        if simplify_factor > 0
          @trailsegments = Trailsegment.find_by_sql(["select *, st_linemerge(geom::geometry) as merged_geom from trailsegments"]);
        else
          if trailID
            trail_name = Trail.find(trailID).name
            @trailsegments = Trailsegment.where("trail1 = ? 
              OR trail2 = ? 
              OR trail3 = ?
              OR trail4 = ?
              OR trail5 = ?
              OR trail6 = ?", trail_name, trail_name, trail_name, trail_name, trail_name, trail_name)
          else
            @trailsegments = cached_all_by_name
          end
        end

        if stale?(@trailsegments)
        @entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        line_factory = ::RGeo::Geographic.spherical_factory(:srid => 4326)
        features = []

        @trailsegments.each do |trailsegment|
          merged_geom = trailsegment.attributes["merged_geom"]
          if simplify_factor > 0
            if merged_geom.geometry_type.type_name == "MultiLineString" # for multilinestrings we need to loop through contained linestrings
              new_trailsegment_linestrings = []
              merged_geom.each_with_index do |linestring, ls_index|
                new_linestring_points = []
                linestring.points.each_with_index do |point, p_index| # and then loop through the points in each linestring
                  if p_index % simplify_factor == 0 || p_index == linestring.num_points - 1
                    new_linestring_points.push(point)
                  end
                end
                new_trailsegment_linestrings.push(line_factory.line_string(new_linestring_points))
              end
              simplified_trailsegment_geom = line_factory.multi_line_string(new_trailsegment_linestrings)
              trailsegment.geom = simplified_trailsegment_geom

            elsif merged_geom.geometry_type.type_name == "LineString" # for linestrings we can just loop through the points
              new_linestring_points = []
              merged_geom.points.each_with_index do |point, p_index|
                if p_index % simplify_factor == 0 || p_index == merged_geom.num_points() - 1
                  new_linestring_points.push(point)
                end
              end
              simplified_trailsegment_geom = line_factory.line_string(new_linestring_points)
              trailsegment.geom = simplified_trailsegment_geom
            end
          end
          json_attributes = create_json_attributes(trailsegment)
          feature = @entity_factory.feature(trailsegment.geom, 
            trailsegment.id, 
            json_attributes)
          features.push(feature)
        end
        collection = @entity_factory.feature_collection(features)
        my_geojson = RGeo::GeoJSON::encode(collection)
        ojDump = Oj.dump(my_geojson)
        #if stale?(ojDump)
          render json: ojDump
        end
      end
    end
  end

  # GET /trailsegments/1
  # GET /trailsegments/1.json
  def show
    respond_to do |format|
      format.html
      format.json do
        @entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        json_attributes = create_json_attributes(@trailsegment)
        feature = @entity_factory.feature(@trailsegment.geom, @trailsegment.id, json_attributes )
        render json: RGeo::GeoJSON::encode(feature)
      end
    end
  end

  # GET /trailsegments/new
  # def new
  #   @trailsegment = Trailsegment.new
  # end

  # GET /trailsegments/1/edit
  def edit
    unless authorized?
      redirect_to trailsegments_path, notice: 'Authorization failure.'
    end
  end

  # # POST /trailsegments
  # # POST /trailsegments.json
  # def create
  #   @trailsegment = Trailsegment.new(trailsegment_params)

  #   respond_to do |format|
  #     if @trailsegment.save
  #       format.html { redirect_to trailsegments_path, notice: 'Trail segment was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @trailsegment }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @trailsegment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /trailsegments/1
  # PATCH/PUT /trailsegments/1.json
  def update
    respond_to do |format|
      if authorized? && @trailsegment.update(trailsegment_params)
        format.html { redirect_to trailsegments_path, notice: 'Trailsegment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trailsegment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trailsegments/1
  # DELETE /trailsegments/1.json
  def destroy
    respond_to do |format|
      if authorized? && @trailsegment.destroy
        format.html { redirect_to trailsegments_url, notice: "Trail segment was successfully deleted." }
        format.json { render :json => { head: :no_content }, status: :ok }
      else
        format.html { redirect_to trailsegments_url, notice: "Trail segment was not deleted."}
        format.json { render :json => { head: :no_content }, status: :unprocessable_entity }
      end
    end
  end

  def upload
    if !current_user
      head 403
    end
    @confirmed = params[:confirmed] ? true : false
    redirect_to trailsegments_url, notice: "Please enter a source organization code for uploading trail segment data." if params[:source_id].empty?
    source_id = params[:source_id]
    @source = Organization.find(source_id)
    parsed_trailsegments = Trailsegment.parse(params[:trailsegments])
    if parsed_trailsegments.nil?
      redirect_to trailsegments_url, notice: "Unable to parse file #{params[:trailsegments].orginial_filename}. Make sure it is a valid GeoJSON file or zipped shapefile."
      return
    end
    source_trailsegments = Trailsegment.where(source: @source)
    @non_source_trailsegments = Trailsegment.where.not(source: @source)
    @removed_trailsegments = []
    source_trailsegments.each do |old_trailsegment|
      removed_trailsegment = Hash.new
      removed_trailsegment[:trailsegment] = old_trailsegment
      if @confirmed
        removed_trailsegment[:success] = old_trailsegment.destroy
      else
        removed_trailsegment[:success] = true
      end
      @removed_trailsegments.push(removed_trailsegment)
    end
    @added_trailsegments = []
    parsed_trailsegments.each do |new_trailsegment|
      added_trailsegment = Hash.new
      added_trailsegment[:trailsegment] = new_trailsegment
      if new_trailsegment.source != @source
        added_trailsegment[:success] = false
        if !new_trailsegment.source.nil?
          added_trailsegment[:message] = "Trail segment organization #{new_trailsegment.source.code} doesn't match user organization #{@source.code}."
        else
          added_trailsegment[:message] = "No trail segment source found."
        end
      elsif @confirmed
        if (new_trailsegment.save)
          added_trailsegment[:success] = true
        else
          added_trailsegment[:success] = false
          added_trailsegment[:message] = new_trailsegment.errors.full_messages
        end
      else
        if (new_trailsegment.valid?)
          added_trailsegment[:success] = true
        else
          if new_trailsegment.errors.full_messages == ["Geom has already been taken"]
            added_trailsegment[:success] = true
          else
            added_trailsegment[:success] = false
            added_trailsegment[:message] = new_trailsegment.errors.full_messages
          end
        end
      end
      @added_trailsegments.push(added_trailsegment)
    end
  end

  def default_url_options
    { all: @show_all }.merge(super)
  end

  def set_show_all_param
    @show_all = params[:all] if params[:all]
  end

  def create_json_attributes(trailsegment)
    json_attributes = trailsegment.attributes.except("id", "segment_id", "geom", "wkt", "created_at", "updated_at", "trail1", "trail2", "trail3", "trail4", "trail5", "trail6", "accessible", "roadbike", "mtnbike", "hike", "equestrian", "xcntryski")
    if trailsegment.source
      json_attributes["source"] = trailsegment.source.code
      json_attributes["source_fullname"] = trailsegment.source.full_name
      json_attributes["source_phone"] = trailsegment.source.phone
      json_attributes["source_url"] = trailsegment.source.url
    end
    if trailsegment.steward
      json_attributes["steward"] = trailsegment.steward.code
      json_attributes["steward_fullname"] = trailsegment.steward.full_name
      json_attributes["steward_phone"] = trailsegment.steward.phone
      json_attributes["steward_url"] = trailsegment.steward.url
    end
    json_attributes["id"] = trailsegment.segment_id
    # json_attributes["trail_ids"] = create_trail_id_list(trailsegment.segment_id)
    json_attributes
  end

  def create_trail_id_list(segment_id)
    trailids = []
    Trail.all.each do |trail|
      segments = trail.segment_ids
      segments.each do |segment|
        if segment == segment_id
          trailids.push(trail.trail_id)
        end
      end
    end
    return trailids 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trailsegment
      @trailsegment = Trailsegment.find(params[:id])
    end

    def set_trailsegments_cache_key
      max_updated_at = Trailsegment.maximum(:updated_at).try(:utc).try(:to_s, :number)
      @@trailsegments_cache_key = "trailsegments/all-#{max_updated_at}"
      puts "NEW trailsegments_cache_key: #{@@trailsegments_cache_key}"
    end  

    def cached_all_by_name
        puts @@trailsegments_cache_key
      if @@trailsegments_cache_key.blank?
        set_trailsegments_cache_key
        puts "Initial Trail cache key is: #{@@trailsegments_cache_key}"
      end
      Rails.cache.fetch("#{@@trailsegments_cache_key}/trailsegments", expires_in: 12.hour) do
        Trailsegment.all
        # last_update = @trailheads.maximum(:updated_at)
      end
    
    end

    def authorized?
      (current_user.organization == @trailsegment.source || current_user.admin?)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trailsegment_params
      params.require(:trailsegment).permit(:length, :trail_ids, :trail_names, :source_id, :steward, :geom, 
        :trail1, :trail2, :trail3, :steward_id, :accessible, :hike, :equestrian, 
        :xcntryski, :dogs, :roadbike, :mtnbike, :trail4, :trail5, :trail6, :segment_id, :foot, :bicycle, :horse, :ski, :wheelchair, :motor_vehicles)
    end

    def check_for_cancel
      if params[:commit] == "Cancel"
        redirect_to trailheads_path
      end
    end    
  end
