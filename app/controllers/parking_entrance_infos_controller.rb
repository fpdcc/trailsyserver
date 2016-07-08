class ParkingEntranceInfosController < ApplicationController
  before_action :set_parking_entrance_info, only: [:show, :edit, :update, :destroy]

  # GET /parking_entrance_infos
  # GET /parking_entrance_infos.json
  def index
    @parking_entrance_infos = ParkingEntranceInfo.all
  end

  # GET /parking_entrance_infos/1
  # GET /parking_entrance_infos/1.json
  def show
  end

  # GET /parking_entrance_infos/new
  def new
    @parking_entrance_info = ParkingEntranceInfo.new
  end

  # GET /parking_entrance_infos/1/edit
  def edit
  end

  # POST /parking_entrance_infos
  # POST /parking_entrance_infos.json
  def create
    @parking_entrance_info = ParkingEntranceInfo.new(parking_entrance_info_params)

    respond_to do |format|
      if @parking_entrance_info.save
        format.html { redirect_to @parking_entrance_info, notice: 'Parking entrance info was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parking_entrance_info }
      else
        format.html { render action: 'new' }
        format.json { render json: @parking_entrance_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parking_entrance_infos/1
  # PATCH/PUT /parking_entrance_infos/1.json
  def update
    respond_to do |format|
      if @parking_entrance_info.update(parking_entrance_info_params)
        format.html { redirect_to @parking_entrance_info, notice: 'Parking entrance info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parking_entrance_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parking_entrance_infos/1
  # DELETE /parking_entrance_infos/1.json
  def destroy
    @parking_entrance_info.destroy
    respond_to do |format|
      format.html { redirect_to parking_entrance_infos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking_entrance_info
      @parking_entrance_info = ParkingEntranceInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parking_entrance_info_params
      params.require(:parking_entrance_info).permit(:parking_entrance_id, :multi_entrance, :private_lot, :lot, :zone_name, :area_name, :fpd_uid, :point_type, :parking_entrance_addr, :trailaccess, :nameid, :parking_info_id, :entrance_closed)
    end
end
