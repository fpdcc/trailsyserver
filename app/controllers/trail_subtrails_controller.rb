class TrailSubtrailsController < ApplicationController
  before_action :set_trail_subtrail, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  caches_page :index, gzip: true, if: -> { request.format.json? }

  # GET /trail_subtrails
  # GET /trail_subtrails.json
  def index
    respond_to do |format|
      format.html do 
        authenticate_user!
        authorize TrailSubtrail
        @trail_subtrails = TrailSubtrail.all.paginate(page: params[:page])
      end
      format.json do
        @trail_subtrails = TrailSubtrail.order(length_mi: :desc)
        #cache_page( "/trail_subtrails.json")
      end
    end
  end

  # GET /trail_subtrails/1
  # GET /trail_subtrails/1.json
  def show
    authorize @trail_subtrail
  end

  # GET /trail_subtrails/new
  def new
    @trail_subtrail = TrailSubtrail.new
    authorize @trail_subtrail
  end

  # GET /trail_subtrails/1/edit
  def edit
    authorize @trail_subtrail
  end

  # POST /trail_subtrails
  # POST /trail_subtrails.json
  def create
    @trail_subtrail = TrailSubtrail.new(trail_subtrail_params)
    authorize @trail_subtrail
    respond_to do |format|
      if @trail_subtrail.save
        format.html { redirect_to @trail_subtrail, notice: 'Trail subtrail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trail_subtrail }
      else
        format.html { render action: 'new' }
        format.json { render json: @trail_subtrail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trail_subtrails/1
  # PATCH/PUT /trail_subtrails/1.json
  def update
    authorize @trail_subtrail
    respond_to do |format|
      if @trail_subtrail.update(trail_subtrail_params)
        format.html { redirect_to @trail_subtrail, notice: 'Trail subtrail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trail_subtrail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trail_subtrails/1
  # DELETE /trail_subtrails/1.json
  def destroy
    authorize @trail_subtrail
    @trail_subtrail.destroy
    respond_to do |format|
      format.html { redirect_to trail_subtrails_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail_subtrail
      @trail_subtrail = TrailSubtrail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trail_subtrail_params
      params.require(:trail_subtrail).permit(TrailSubtrail.column_names - ["created_at", "updated_at"])
    end
end
