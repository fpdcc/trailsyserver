class UpdatesController < ApplicationController
  before_action :set_update, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /updates
  # GET /updates.json
  def index
    authorize Update
    @updates = Update.all
  end

  # GET /updates/1
  # GET /updates/1.json
  def show
    authorize @update
  end

  # GET /updates/new
  def new
    authorize Update
    @update = Update.new
  end

  # GET /updates/1/edit
  def edit
    authorize @update
  end

  # POST /updates
  # POST /updates.json
  def create
    authorize Update
    #logger.info "params = #{params}"
    file = update_params.delete(:data_file)
    data_type = update_params.delete(:data_type)
    contents = file.read
    contentType = file.content_type
    filename = file.original_filename
    logger.info "original_filename = #{filename}"
    @update = Update.new
    @update.filename = filename
    @update.updatedata = {}
    if @update.save
      @update.parse_csv(file, data_type)
    end
    # if @job_enqueue.save
    #   Rails.logger.info("Started trails ingest")
    #   flash[:notice] = "Trails ingest begins"
    # else
    #   Rails.logger.error('Trail Ingest error')
    #   flash[:error] = 'Failed to ingest trails.'
    # end
    #@update['filename'] = params['data_file'].original_filename

    respond_to do |format|
      if @update.save
        logger.info "data_type = #{data_type}"
        if data_type == 'trails'
          @update.parse_trails(contents)
        elsif data_type == 'Pointsofinterest'
          @update.updatedata['Pointsofinterest'] = "Processing..."
          @update.save
          @update.parse_pois(contents)
        elsif data_type == 'trails_descs'
          @update.parse_trails_descs(contents)
        end
        format.html { redirect_to @update, notice: 'Update was successfully created.' }
        format.json { render action: 'show', status: :created, location: @update }
      else
        format.html { render action: 'new' }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /updates/1
  # PATCH/PUT /updates/1.json
  def update
    authorize @update
    respond_to do |format|
      if @update.update(update_params)
        format.html { redirect_to @update, notice: 'Update was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /updates/1
  # DELETE /updates/1.json
  def destroy
    authorize @update
    @update.destroy
    respond_to do |format|
      format.html { redirect_to updates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_update
      @update = Update.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      params.require(:update).permit(:filename, :data_type, :updatedata, :data_file)
      #params[:update]
    end
end
