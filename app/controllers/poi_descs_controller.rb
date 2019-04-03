class PoiDescsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_poi_desc, only: [:show, :edit, :update, :destroy]
  after_action :expire_this_json, only: [:create, :destroy, :update, :upload]

  # GET /poi_descs
  # GET /poi_descs.json
  def index
    @poi_descs = PoiDesc.all.paginate(page: params[:page])
  end

  # GET /poi_descs/1
  # GET /poi_descs/1.json
  def show
  end

  # GET /poi_descs/new
  def new
    @poi_desc = PoiDesc.new
  end

  # GET /poi_descs/1/edit
  def edit
  end

  # POST /poi_descs
  # POST /poi_descs.json
  def create
    @poi_desc = PoiDesc.new(poi_desc_params)

    respond_to do |format|
      if @poi_desc.save
        format.html { redirect_to @poi_desc, notice: 'Poi desc was successfully created.' }
        format.json { render action: 'show', status: :created, location: @poi_desc }
      else
        format.html { render action: 'new' }
        format.json { render json: @poi_desc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poi_descs/1
  # PATCH/PUT /poi_descs/1.json
  def update
    respond_to do |format|
      if @poi_desc.update(poi_desc_params)
        format.html { redirect_to @poi_desc, notice: 'Poi desc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poi_desc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poi_descs/1
  # DELETE /poi_descs/1.json
  def destroy
    @poi_desc.destroy
    respond_to do |format|
      format.html { redirect_to poi_descs_url }
      format.json { head :no_content }
    end
  end

  private
    def expire_this_json
      expire_page("/pointsofinterests.json")
      expire_page("/pointsofinterests.json.gz")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_poi_desc
      @poi_desc = PoiDesc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poi_desc_params
      params.require(:poi_desc).permit(PoiDesc.column_names - ["created_at", "updated_at"])
      #params.require(:poi_desc).permit(:poi_info_id, :fish_map, :hours1, :hours2, :phone, :description, :web_link, :map_link, :map_link_spanish, :vol_link, :vol_link2, :picnic_link, :event_link, :custom_link, :season1, :season2, :special_hours, :special_description, :special_link, :photo_link, :poi_desc_id)
    end
end
