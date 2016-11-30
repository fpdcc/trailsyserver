class AlertingsController < ApplicationController
  before_action :set_alerting, only: [:show, :edit, :update, :destroy]

  # GET /alertings
  # GET /alertings.json
  def index
    @alertings = Alerting.all
  end

  # GET /alertings/1
  # GET /alertings/1.json
  def show
  end

  # GET /alertings/new
  def new
    @alerting = Alerting.new
    #@alerting.alerts.build
  end

  # GET /alertings/1/edit
  def edit
  end

  # POST /alertings
  # POST /alertings.json
  def create
    
    @alert = Alert.find_or_initialize_by(id: params[:alerting][:alert_id])
    @alert.created_by ||= current_user.id
    @alert.description ||= params[:alerting].delete(:description)
    @alert.link ||= params[:alerting].delete(:link)
    @alert.alert_type ||= params[:alerting].delete(:alert_type)
    if params[:alerting][:alert_id].blank?
      @alert.with_user(current_user).save
    end

    @alerting = Alerting.new(alerting_params)
    if params[:alerting][:starts_at].present?
      @alerting.starts_at = Date.strptime(params[:alerting][:starts_at], '%m/%d/%Y')
    end
    if params[:alerting][:ends_at].present?
      @alerting.ends_at = Date.strptime(params[:alerting][:ends_at], '%m/%d/%Y')
    end
    @alerting.alert_id = @alert.id

    respond_to do |format|
      if @alerting.with_user(current_user).save
        format.html { redirect_to :back, notice: 'Alerting was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alerting }
      else
        format.html { render action: 'new' }
        #format.html { redirect_to :back }
        format.json { render json: @alerting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alertings/1
  # PATCH/PUT /alertings/1.json
  def update
    respond_to do |format|
      if @alerting.with_user(current_user).update(alerting_params)
        format.html { redirect_to @alerting, notice: 'Alerting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @alerting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alertings/1
  # DELETE /alertings/1.json
  def destroy
    @alerting.destroy
    respond_to do |format|
      format.html { redirect_to alertings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alerting
      @alerting = Alerting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alerting_params
      params.require(:alerting).permit(:alertable_type, :alertable_id, :alert_id, :starts_at, :ends_at, :created_by, 
        :alerts_attributes => [:alert_type, :description, :link], :alertable_types, :alertable_ids
        )
    end
end
