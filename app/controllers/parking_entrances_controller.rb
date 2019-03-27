class ParkingEntrancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parking_entrance, only: [:show, :edit, :update, :destroy]
  after_action :expire_this_json, only: [:create, :destroy, :update, :upload]

  # GET /parking_entrances
  # GET /parking_entrances.json
  def index
    @parking_entrances = ParkingEntrance.all
  end

  # GET /parking_entrances/1
  # GET /parking_entrances/1.json
  def show
  end

  # GET /parking_entrances/new
  def new
    @parking_entrance = ParkingEntrance.new
  end

  # GET /parking_entrances/1/edit
  def edit
  end

  # POST /parking_entrances
  # POST /parking_entrances.json
  def create
    @parking_entrance = ParkingEntrance.new(parking_entrance_params)

    respond_to do |format|
      if @parking_entrance.save
        format.html { redirect_to @parking_entrance, notice: 'Parking entrance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parking_entrance }
      else
        format.html { render action: 'new' }
        format.json { render json: @parking_entrance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parking_entrances/1
  # PATCH/PUT /parking_entrances/1.json
  def update
    respond_to do |format|
      if @parking_entrance.update(parking_entrance_params)
        format.html { redirect_to @parking_entrance, notice: 'Parking entrance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parking_entrance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parking_entrances/1
  # DELETE /parking_entrances/1.json
  def destroy
    @parking_entrance.destroy
    respond_to do |format|
      format.html { redirect_to parking_entrances_url }
      format.json { head :no_content }
    end
  end

  private

    def expire_this_json
      expire_page("/pointsofinterests.json")
      expire_page("/pointsofinterests.json.gz")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_parking_entrance
      @parking_entrance = ParkingEntrance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parking_entrance_params
      params.require(:parking_entrance).permit(:parking_entrance_id, :geom)
    end
end
