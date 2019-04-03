class TrailSystemsController < ApplicationController
  before_action :set_trail_system, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /trail_systems
  # GET /trail_systems.json
  def index
    authorize TrailSystem
    @trail_systems = TrailSystem.all
  end

  # GET /trail_systems/1
  # GET /trail_systems/1.json
  def show
    authorize @trail_system
    respond_to do |format|
      format.json do
        @alerts = @trail_system.alerts.current_or_near_future
      end
      format.html do
      end
    end
  end

  # GET /trail_systems/new
  def new
    @trail_system = TrailSystem.new
    authorize @trail_system
  end

  # GET /trail_systems/1/edit
  def edit
    authorize @trail_system
  end

  # POST /trail_systems
  # POST /trail_systems.json
  def create
    @trail_system = TrailSystem.new(trail_system_params)
    authorize @trail_system
    respond_to do |format|
      if @trail_system.save
        format.html { redirect_to @trail_system, notice: 'Trail system was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trail_system }
      else
        format.html { render action: 'new' }
        format.json { render json: @trail_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trail_systems/1
  # PATCH/PUT /trail_systems/1.json
  def update
    authorize @trail_system
    respond_to do |format|
      if @trail_system.update(trail_system_params)
        format.html { redirect_to @trail_system, notice: 'Trail system was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trail_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trail_systems/1
  # DELETE /trail_systems/1.json
  def destroy
    authorize @trail_system
    @trail_system.destroy
    respond_to do |format|
      format.html { redirect_to trail_systems_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail_system
      @trail_system = TrailSystem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trail_system_params
      params.require(:trail_system).permit(TrailSystem.column_names - ["created_at", "updated_at"])
      #params.require(:trail_system).permit(:trail_subsystem)
    end
end
