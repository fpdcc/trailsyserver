class TrailsDescsController < ApplicationController
  before_action :set_trails_desc, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]


  # GET /trails_descs
  # GET /trails_descs.json
  def index
    authorize TrailsDesc
    @trails_descs = TrailsDesc.all
  end

  # GET /trails_descs/1
  # GET /trails_descs/1.json
  def show
    authorize @trails_desc
  end

  # GET /trails_descs/new
  def new
    @trails_desc = TrailsDesc.new
    authorize @trails_desc
  end

  # GET /trails_descs/1/edit
  def edit
    authorize @trails_desc
  end

  # POST /trails_descs
  # POST /trails_descs.json
  def create
    @trails_desc = TrailsDesc.new(trails_desc_params)
    authorize @trails_desc
    respond_to do |format|
      if @trails_desc.save
        format.html { redirect_to @trails_desc, notice: 'Trails desc was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trails_desc }
      else
        format.html { render action: 'new' }
        format.json { render json: @trails_desc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trails_descs/1
  # PATCH/PUT /trails_descs/1.json
  def update
    authorize @trails_desc
    respond_to do |format|
      if @trails_desc.update(trails_desc_params)
        format.html { redirect_to @trails_desc, notice: 'Trails desc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trails_desc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trails_descs/1
  # DELETE /trails_descs/1.json
  def destroy
    authorize @trails_desc
    @trails_desc.destroy
    respond_to do |format|
      format.html { redirect_to trails_descs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trails_desc
      @trails_desc = TrailsDesc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trails_desc_params
      params.require(:trails_desc).permit(TrailsDesc.column_names - ["created_at", "updated_at"])
      #params.require(:trails_desc).permit(:trail_desc_id, :trail_subsystem, :alt_name, :trail_desc, :map_link, :map_link_spanish)
    end
end
