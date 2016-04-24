class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all

    respond_to do |format|
      format.html do
        authenticate_user!
        if !user_signed_in? || (!current_user.admin && current_user.organization.nil?)
          sign_out :user
          redirect_to statuses_path
          return  
        end
        @statuses = Status.all
      end
      format.json do
          @statuses = Status.all
        # if params[:source_id].nil?
        #   @trails = cached_all_by_name
        # else
        #   @trails = Trail.includes([:photorecord]).where(source_id: params[:source_id]).order("name")
        # end

        #if stale?(@trails)
        entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        features = []
        @statuses.each do |status|
          # taking a trip to Null Island, because RGeo::GeoJSON chokes on empty geometry here
          json_attributes = create_json_attributes(status)
          feature = entity_factory.feature(RGeo::Geographic.spherical_factory.point(0,0), status.id, json_attributes)
          features.push(feature)
        end
        collection = entity_factory.feature_collection(features)
        my_geojson = RGeo::GeoJSON::encode(collection)
        ojDump = Oj.dump(my_geojson)
        #if stale?(ojDump)
          render json: ojDump
        #end
      end
      format.csv do
        #if params[:source_id].nil?
          @statuses = Status.all
        #else
        #  @trails = Trail.includes([:photorecord]).where(source_id: params[:source_id]).order("name")
        #end
        render text: @statuses.to_csv
      end
    end
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
  end

  # GET /statuses/new
  def new
    @status = Status.new
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @status }
      else
        format.html { render action: 'new' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url }
      format.json { head :no_content }
    end
  end

  def create_json_attributes(status)
    json_attributes = status.attributes.clone.except!("created_at", "updated_at", "statusable_id")
    if status.statusable_type == "Trailhead"
      json_attributes["statusable_id"] = status.statusable.trailhead_id
    elsif status.statusable_type == "Trail"
      json_attributes["statusable_id"] = status.statusable.trail_id
    #   json_attributes["source_fullname"] = trail.source.full_name
    #   json_attributes["source_phone"] = trail.source.phone
    #   json_attributes["source_url"] = trail.source.url
    #   json_attributes["source_logo_url"] = trail.source.logo.url(:medium)
    end
    # if trail.steward 
    #   json_attributes["steward"] = trail.steward.code
    #   json_attributes["steward_fullname"] = trail.steward.full_name
    #   json_attributes["steward_phone"] = trail.steward.phone
    #   json_attributes["steward_url"] = trail.steward.url
    #   json_attributes["steward_logo_url"] = trail.steward.logo.url(:medium)
    # end
    # if trail.photorecord
    #   json_attributes["orig_photo_url"] = trail.photorecord.photo.url
    #   json_attributes["medium_photo_url"] = trail.photorecord.photo.url(:medium)
    #   json_attributes["thumb_photo_url"] = trail.photorecord.photo.url(:thumb)
    #   json_attributes["photo_credit"] = trail.photorecord.credit
    # end
    #json_attributes["id"] = trail.trail_id
    json_attributes
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:status_type, :reason, :title, :description, :start_date, :end_date, :statusable_type, :statusable_id, :created_by)
    end
  end
