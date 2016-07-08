class TrailsInfosController < ApplicationController
  before_action :set_trails_info, only: [:show, :edit, :update, :destroy]

  # GET /trails_infos
  # GET /trails_infos.json
  def index
    @trails_infos = TrailsInfo.all
  end

  # GET /trails_infos/1
  # GET /trails_infos/1.json
  def show
  end

  # GET /trails_infos/new
  def new
    @trails_info = TrailsInfo.new
  end

  # GET /trails_infos/1/edit
  def edit
  end

  # POST /trails_infos
  # POST /trails_infos.json
  def create
    @trails_info = TrailsInfo.new(trails_info_params)

    respond_to do |format|
      if @trails_info.save
        format.html { redirect_to @trails_info, notice: 'Trails info was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trails_info }
      else
        format.html { render action: 'new' }
        format.json { render json: @trails_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trails_infos/1
  # PATCH/PUT /trails_infos/1.json
  def update
    respond_to do |format|
      if @trails_info.update(trails_info_params)
        format.html { redirect_to @trails_info, notice: 'Trails info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trails_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trails_infos/1
  # DELETE /trails_infos/1.json
  def destroy
    @trails_info.destroy
    respond_to do |format|
      format.html { redirect_to trails_infos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trails_info
      @trails_info = TrailsInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trails_info_params
      params.require(:trails_info).permit(:trail_system, :trail_subsystem, :trail_color, :trail_surface, :trail_type, :trail_difficulty, :regional_trail_name, :trail_desc, :gps, :comment, :alt_name, :cambr_name, :on_street, :crossing_type, :unrecognized, :length_mi, :trails_id, :off_fpdcc, :web_trail, :maintenance, :length_ft, :trail_info_id)
    end
end
