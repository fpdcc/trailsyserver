class PoiToTrailsController < ApplicationController
  before_action :set_poi_to_trail, only: [:show, :edit, :update, :destroy]

  # GET /poi_to_trails
  # GET /poi_to_trails.json
  def index
    @poi_to_trails = PoiToTrail.all
  end

  # GET /poi_to_trails/1
  # GET /poi_to_trails/1.json
  def show
  end

  # GET /poi_to_trails/new
  def new
    @poi_to_trail = PoiToTrail.new
  end

  # GET /poi_to_trails/1/edit
  def edit
  end

  # POST /poi_to_trails
  # POST /poi_to_trails.json
  def create
    @poi_to_trail = PoiToTrail.new(poi_to_trail_params)

    respond_to do |format|
      if @poi_to_trail.save
        format.html { redirect_to @poi_to_trail, notice: 'Poi to trail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @poi_to_trail }
      else
        format.html { render action: 'new' }
        format.json { render json: @poi_to_trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poi_to_trails/1
  # PATCH/PUT /poi_to_trails/1.json
  def update
    respond_to do |format|
      if @poi_to_trail.update(poi_to_trail_params)
        format.html { redirect_to @poi_to_trail, notice: 'Poi to trail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poi_to_trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poi_to_trails/1
  # DELETE /poi_to_trails/1.json
  def destroy
    @poi_to_trail.destroy
    respond_to do |format|
      format.html { redirect_to poi_to_trails_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poi_to_trail
      @poi_to_trail = PoiToTrail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poi_to_trail_params
      params.require(:poi_to_trail).permit(:trail_info_id, :poi_info_id, :distance)
    end
end
