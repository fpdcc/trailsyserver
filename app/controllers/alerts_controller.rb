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
    @alert.alertings.build
  end

  # GET /alerts/1/edit
  def edit
    #@alert.alertings.build
  end

  # POST /alerts
  # POST /alerts.json

  def create
    @alert = Alert.new(alert_params)
    starts_at = alert_params['starts_at']
    ends_at = alert_params['ends_at']
    if starts_at.present?
      @alert.starts_at = Date.strptime(starts_at, '%m/%d/%Y')
    end
    if ends_at.present?
      @alert.ends_at = Date.strptime(ends_at, '%m/%d/%Y')
    end

    respond_to do |format|
      if @alert.with_user(current_user).save
        logger.info "New alert saved: #{@alert}"
        format.html { redirect_to request.referrer, notice: 'Alert was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alert }
      else
        logger.info "Problem saving new alert: #{@alert}"
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
    logger.info "params = #{params}"
    logger.info "alert_params = #{alert_params}"
    starts_at = alert_params['starts_at']
    ends_at = alert_params['ends_at']
    if starts_at.present?
      @alert.starts_at = Date.strptime(starts_at, '%m/%d/%Y')
      logger.info "update: alert_params['starts_at'] = #{alert_params['starts_at']} and updated @alert.starts_at = #{@alert.starts_at}"
    end
    if ends_at.present?
      @alert.ends_at = Date.strptime(ends_at, '%m/%d/%Y')
    end

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


  def poi
    @pointsofinterests_active = Pointsofinterest.with_current_or_future_alerts #.order(self.active_alerts_count)
    query = ""
    if params[:name].present?
      query = "name ILIKE ?", "#{params[:name]}%"
    end
    @q = Pointsofinterest.ransack(params[:q])
    @pointsofinterests = @q.result.paginate(page: params[:page]).includes(:alerts)
    @alert = Alert.new
    @alert.alertings.build
  end

  def trail
    @trails_active = TrailSystem.with_current_or_future_alerts
    query = ""
    if params[:trail_subsystem].present?
      query = "trail_subsystem ILIKE ?", "#{params[:trail_subsystem]}%"
    end
    @q = TrailSystem.ransack(params[:q])
    @trails = @q.result.paginate(page: params[:page])
    @alert = Alert.new
    @alert.alertings.build
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alert_params
      params.require(:alert).permit(:alert_id, :alert_type, :description, :link, :created_by, :starts_at, :ends_at, :geom,
        alertings_attributes: [:id, :alert_id, :alertable_id, :alertable_type, :created_by]
        )
    end
end
