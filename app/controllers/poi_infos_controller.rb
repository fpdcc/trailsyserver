class PoiInfosController < ApplicationController
  before_action :set_poi_info, only: [:show, :edit, :update, :destroy]

  # GET /poi_infos
  # GET /poi_infos.json
  def index
    @poi_infos = PoiInfo.all
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poi_info
      @poi_info = PoiInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poi_info_params
      params.require(:poi_info).permit(:poi_info_id, :point_type, :addr, :zip, :zipmuni, :municipality, :public_access, :latitude, :longitude, :commdist, :zone_name, :zonemapno, :dwmapno, :nameid, :pointsofinterest_id, :fpd_uid, :web_poi, :web_street_addr, :web_muni_addr, :parking_connection_id, :parking_info_id, :alt_nameid, :alt2_nameid)
    end
end
