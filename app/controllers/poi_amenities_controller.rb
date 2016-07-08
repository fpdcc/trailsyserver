class PoiAmenitiesController < ApplicationController
  before_action :set_poi_amenity, only: [:show, :edit, :update, :destroy]

  # GET /poi_amenities
  # GET /poi_amenities.json
  def index
    @poi_amenities = PoiAmenity.all
  end

  # GET /poi_amenities/1
  # GET /poi_amenities/1.json
  def show
  end

  # GET /poi_amenities/new
  def new
    @poi_amenity = PoiAmenity.new
  end

  # GET /poi_amenities/1/edit
  def edit
  end

  # POST /poi_amenities
  # POST /poi_amenities.json
  def create
    @poi_amenity = PoiAmenity.new(poi_amenity_params)

    respond_to do |format|
      if @poi_amenity.save
        format.html { redirect_to @poi_amenity, notice: 'Poi amenity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @poi_amenity }
      else
        format.html { render action: 'new' }
        format.json { render json: @poi_amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poi_amenities/1
  # PATCH/PUT /poi_amenities/1.json
  def update
    respond_to do |format|
      if @poi_amenity.update(poi_amenity_params)
        format.html { redirect_to @poi_amenity, notice: 'Poi amenity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poi_amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poi_amenities/1
  # DELETE /poi_amenities/1.json
  def destroy
    @poi_amenity.destroy
    respond_to do |format|
      format.html { redirect_to poi_amenities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poi_amenity
      @poi_amenity = PoiAmenity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poi_amenity_params
      params.require(:poi_amenity).permit(:poi_info_id, :ada, :bike_parking, :bike_rental, :birding, :boat_ramp, :boat_rental, :camping, :canoe, :comfortstation, :cross_country, :cycling, :disc_golf, :dog_friendly, :dog_leash, :drinkingwater, :drone, :ecological, :equestrian, :fishing, :ice_fishing, :gas_powered, :golf, :hiking, :indoor_rental, :large_capacity, :m_airplane, :m_boat, :nature_center, :natureplay, :no_alcohol, :no_parking, :overlook, :pavillion, :picnic_grove, :shelter, :skating_ice, :skating_inline, :sledding, :snowmobile, :swimming, :toboggan, :volunteer, :zip_line, :poi_amenity_id)
    end
end
