class AlertingsController < ApplicationController
  before_action :set_alerting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  # GET /alertings
  # GET /alertings.json
  def index
    respond_to do |format|
      format.html do 
        authenticate_user!
        @alertings = Alerting.all
      end
      format.json do
        @alertings = Alerting.current
        entity_factory = ::RGeo::GeoJSON::EntityFactory.instance
        # if (params[:loc])
        #   @alertings = sort_by_distance(@alertings)
        # end
        features = []
        @alertings.each do |alerting|
          json_attributes = create_json_attributes(alerting)
          if alerting.geom.present?
            alerting_geom = alerting.geom
          else
            alerting_geom = RGeo::Geographic.spherical_factory.point(0,0)
          end
          feature = entity_factory.feature(alerting_geom, alerting.id, json_attributes)
          features.push(feature)
        end
        collection = entity_factory.feature_collection(features)
        my_geojson = RGeo::GeoJSON::encode(collection)
        render json: Oj.dump(my_geojson)
        #cache_page(@response, "/alertings.json")
      end
    end
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
    @alerting = Alerting.new(alerting_params)
    respond_to do |format|
      if @alerting.with_user(current_user).save
        format.html { redirect_to :@alerting, notice: "#{@alerting.alert.alert_type} was successfully created for #{@alerting.alertable.name}." }
        format.json { render action: 'show', status: :created, location: @alerting }
      else
        format.html { render action: 'new' }
        #format.html { redirect_to :back }
        format.json { render json: @alerting.errors, status: :unprocessable_entity }
      end
    end
  end

  # def create
  #   factory = ::RGeo::Geographic.spherical_factory(:srid => 4326)
    
  #   @alert = Alert.find_or_initialize_by(id: params[:alerting][:alert_id])
  #   @alert.created_by ||= current_user.id
  #   @alert.description ||= params[:alerting].delete(:description)
  #   @alert.link ||= params[:alerting].delete(:link)
  #   @alert.alert_type ||= params[:alerting].delete(:alert_type)
  #   if params[:alerting][:alert_id].blank?
  #     @alert.with_user(current_user).save
  #   end

  #   @alerting = Alerting.new(alerting_params)
  #   if params[:alerting][:starts_at].present?
  #     @alerting.starts_at = Date.strptime(params[:alerting][:starts_at], '%m/%d/%Y')
  #   end
  #   if params[:alerting][:ends_at].present?
  #     @alerting.ends_at = Date.strptime(params[:alerting][:ends_at], '%m/%d/%Y')
  #   end
  #   @alerting.alert_id = @alert.id

  #   if (params[:alerting][:latitude].present? && params[:alerting][:longitude].present?)
  #     @alerting.geom = factory.point(params[:alerting][:longitude], params[:alerting][:latitude])
  #   end


  #   respond_to do |format|
  #     if @alerting.with_user(current_user).save
  #       format.html { redirect_to :back, notice: "#{@alerting.alert.alert_type} was successfully created for #{@alerting.alertable.name}." }
  #       format.json { render action: 'show', status: :created, location: @alerting }
  #     else
  #       format.html { render action: 'new' }
  #       #format.html { redirect_to :back }
  #       format.json { render json: @alerting.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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

  def create_json_attributes(alerting)
    json_attributes = alerting.attributes.except!("id", "alert_id", "alertable_id","alertable_type","starts_at", "ends_at", "created_by", "created_at", "updated_at", "alerting_id", "geom")
    
    json_attributes["starts_at"] = alerting.starts_at.strftime('%m/%d/%Y')
    if alerting.ends_at.present?
      ends_at = alerting.ends_at.strftime('%m/%d/%Y')
    else
      ends_at = ""
    end
    json_attributes["ends_at"] = ends_at
    if (alerting.alert)
      json_attributes['description'] = alerting.alert.description
      json_attributes['link'] = alerting.alert.link
      json_attributes['alert_type'] = alerting.alert.alert_type
    end
    if (alerting.alertable)
      json_attributes['feature_name'] = alerting.alertable.name
      json_attributes['feature_id'] = alerting.alertable.id
      json_attributes['feature_type'] = alerting.alertable_type
    else
      json_attributes['feature_type'] = "All"
    end
    json_attributes
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alerting
      @alerting = Alerting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alerting_params
      params.require(:alerting).permit(:geom, :alertable_type, :alertable_id, :alert_id, :starts_at, :ends_at, :created_by, :alertable_types, :alertable_ids,
        :alerts_attributes => [:alert_type, :description, :link]
        )
    end
end
