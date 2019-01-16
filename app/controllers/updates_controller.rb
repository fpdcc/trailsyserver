class UpdatesController < ApplicationController
  before_action :set_update, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /updates
  # GET /updates.json
  def index
    authorize Update
    @updates = Update.order(created_at: :desc)
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
    logger.info "update_params = #{update_params}"
    original_filename = update_params[:file].original_filename
    new_filename = Time.now.to_formatted_s(:number) + original_filename
    path = File.join(Rails.root, 'tmp', 'upload', new_filename)
    file = File.write(path, update_params[:file].read)
    data_type = update_params.delete(:data_type)
    #logger.info "original_filename = #{original_filename}"
    logger.info "path = #{path}"
    @update = Update.new
    @update.filename = new_filename
    @update.updatedata = {}
    if data_type == 'Trail'
      @update.updatedata['TrailsInfo'] = []
      @update.updatedata['TrailSystem'] =  []
      @update.updatedata['NewTrail'] =  []
      @update.updatedata['TrailSubtrail'] =  []
    elsif data_type == 'Pointsofinterest'
      @update.updatedata['Pointsofinterest'] =  []
    elsif data_type == 'trails_descs'
      @update.updatedata['TrailsDesc'] = []
    end
    @update.status = "Starting..."
    respond_to do |format|
      if @update.save
        ImportFileJob.perform_later(path, data_type, @update)
        # logger.info "data_type = #{data_type}"
        # if data_type == 'trails'
        #   @update.parse_trails(contents)
        # elsif data_type == 'Pointsofinterest'
        #   @update.updatedata['Pointsofinterest'] = "Processing..."
        #   @update.save
        #   @update.parse_pois(contents)
        # elsif data_type == 'trails_descs'
        #   @update.parse_trails_descs(contents)
        # end
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
        if update_params['approved'].present?
          logger.info "approved is set as: " + update_params['approved']
          if update_params['approved'] == "1"
            logger.info "The current user is: " + current_user.id.to_s
            @update.approved_by = current_user.id
            @update.save
            @update.perform_update
          end
        end
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
      params.require(:update).permit(:filename, :data_type, :updatedata, :file, :approved, :created_by, :approved_by, :run_at)
      #params[:update]
    end
end
