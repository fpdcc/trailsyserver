class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /alerts
  # GET /alerts.json
  def index
    authenticate_user!
    @alerts = Alert.all
  end

  # GET /alerts/1
  # GET /alerts/1.json
  def show
  end

  # GET /alerts/new
  def new
    @alert = Alert.new
  end

  # GET /alerts/1/edit
  def edit
  end

  # POST /alerts
  # POST /alerts.json
  def create
    @alert = Alert.new(alert_params)
    alert_created = @alert.with_user(current_user).save
    logger.info "alert_created: #{alert_created}"
    if alert_created
    # Alerting variables
      logger.info "In alert_created if statement"
      logger.info "What are alert_params?: #{alert_params}"
      if (alert_params['starts_at'].present?)
        logger.info "In starts_at.present if statement"
        alertable_ids = alert_params['alertable_ids'].reject(&:blank?)
        alertable_type = alert_params['alertable_type']
        start_date = alert_params['starts_at']
        end_date = alert_params['ends_at']
        if end_date.present?
          end_date = Date.strptime(end_date, '%m/%d/%Y')
        end
        more_link = alert_params['link']
        description = alert_params['description']
        alertable_ids.each do |alertable|
          @new_alerting = Alerting.new(
            alertable_id: alertable,
            alertable_type: alertable_type,
            starts_at: Date.strptime(start_date, '%m/%d/%Y'),
            ends_at: end_date,
            alert_id: @alert.id
            )
          logger.info "@new_alerting = #{@new_alerting}"
          if @new_alerting.with_user(current_user).save
            logger.info "Created new alerting #{@new_alerting.id}"
          else
            logger.info "Error saving alerting: #{@new_alerting.errors}"
          end
        end
      end
    end

    respond_to do |format|
      if alert_created
        format.html { redirect_to @alert, notice: 'Alert was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alert }
      else
        format.html { render action: 'new' }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_multiple
    @alert = Alert.new(alert_params)


    respond_to do |format|
      if @alert.with_user(current_user).save
        format.html { redirect_to @alert, notice: 'Alert was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alert }
      else
        format.html { render action: 'new' }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alerts/1
  # PATCH/PUT /alerts/1.json
  def update
    respond_to do |format|
      if @alert.with_user(current_user).update(alert_params)
        format.html { redirect_to @alert, notice: 'Alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.json
  def destroy
    @alert.destroy
    respond_to do |format|
      format.html { redirect_to alerts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alert_params
      params.require(:alert).permit(:alert_id, :alert_type, :description, :link, :created_by, :alertable_type, :starts_at, :ends_at, alertable_ids: [], 
        alertings_attributes: [:alertable_ids, :alertable_type, :created_by]
        )
    end
end
