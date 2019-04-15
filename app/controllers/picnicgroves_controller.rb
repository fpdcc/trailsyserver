class PicnicgrovesController < ApplicationController
  before_action :set_picnicgrofe, only: [:show, :edit, :update, :destroy]
  after_action :expire_this_json, only: [:destroy, :update, :upload]
  before_action :authenticate_user!, except: [:index]


  # GET /picnicgroves
  # GET /picnicgroves.json
  def index
    respond_to do |format|
      format.html do 
        authenticate_user!
        authorize Picnicgrofe
        @picnicgroves = Picnicgrofe.all.paginate(page: params[:page])
      end
      format.json do
        @picnicgroves = Picnicgrofe.order("picnicgrove_id")
        entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        # if (params[:loc])
        #   @activities = sort_by_distance(@activities)
        # end
        features = []
        @picnicgroves.each do |picnicgrofe|
          json_attributes = create_json_attributes(picnicgrofe)
          feature = entity_factory.feature(picnicgrofe.geom, 
           picnicgrofe.id, 
           json_attributes)
          features.push(feature)
        end
        collection = entity_factory.feature_collection(features)
        my_geojson = RGeo::GeoJSON::encode(collection)
        render json: Oj.dump(my_geojson)
        cache_page(@response, "/picnicgroves.json")
      end
    end
  end

  # GET /picnicgroves/1
  # GET /picnicgroves/1.json
  def show
    authorize @picnicgrofe
  end

  # GET /picnicgroves/new
  def new
    @picnicgrofe = Picnicgrofe.new
    authorize @picnicgrofe
  end

  # GET /picnicgroves/1/edit
  def edit
    authorize @picnicgrofe
  end

  # POST /picnicgroves
  # POST /picnicgroves.json
  def create
    @picnicgrofe = Picnicgrofe.new(picnicgrofe_params)
    authorize @picnicgrofe
    respond_to do |format|
      if @picnicgrofe.save
        format.html { redirect_to @picnicgrofe, notice: 'Picnicgrofe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @picnicgrofe }
      else
        format.html { render action: 'new' }
        format.json { render json: @picnicgrofe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /picnicgroves/1
  # PATCH/PUT /picnicgroves/1.json
  def update
    authorize @picnicgrofe
    respond_to do |format|
      if @picnicgrofe.update(picnicgrofe_params)
        format.html { redirect_to @picnicgrofe, notice: 'Picnicgrofe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @picnicgrofe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /picnicgroves/1
  # DELETE /picnicgroves/1.json
  def destroy
    authorize @picnicgrofe
    @picnicgrofe.destroy
    respond_to do |format|
      format.html { redirect_to picnicgroves_url }
      format.json { head :no_content }
    end
  end

  def create_json_attributes(picnicgrofe)
    json_attributes = picnicgrofe.attributes.except("status", "division", "id", "geom", "created_at", "updated_at")
    # if activity.source
    #   json_attributes["source"] = activity.source.code
    #   json_attributes["source_fullname"] = activity.source.full_name
    #   json_attributes["source_phone"] = activity.source.phone
    #   json_attributes["source_url"] = activity.source.url
    # end
    # if activity.steward
    #   json_attributes["steward"] = activity.steward.code
    #   json_attributes["steward_fullname"] = activity.steward.full_name
    #   json_attributes["steward_phone"] = activity.steward.phone
    #   json_attributes["steward_url"] = activity.steward.url
    # end
    #json_attributes["distance"] = activity.distance
    json_attributes["id"] = picnicgrofe.picnicgrove_id
    #json_attributes["name"] = activity.name.name
    json_attributes
  end

  private
    def expire_this_json
      expire_page("/picnicgroves.json")
      expire_page("/picnicgroves.json.gz")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_picnicgrofe
      @picnicgrofe = Picnicgrofe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picnicgrofe_params
      #params.require(:picnicgrofe).permit(:picnicgrove_id, :preserve_name, :grove, :division, :capacity, :large_capacity, :grove_type, :location, :status, :fpd_uid, :poi_info_id, :geom)
      params.require(:picnicgrofe).permit(Picnicgrofe.column_names - ["created_at", "updated_at"])
    end
end
