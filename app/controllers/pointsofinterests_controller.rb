class PointsofinterestsController < ApplicationController
  before_action :set_pointsofinterest, only: [:show, :edit, :update, :destroy]

  # GET /pointsofinterests
  # GET /pointsofinterests.json
  def index
    @pointsofinterests = Pointsofinterest.all
  end

  # GET /pointsofinterests/1
  # GET /pointsofinterests/1.json
  def show
  end

  # GET /pointsofinterests/new
  def new
    @pointsofinterest = Pointsofinterest.new
  end

  # GET /pointsofinterests/1/edit
  def edit
  end

  # POST /pointsofinterests
  # POST /pointsofinterests.json
  def create
    @pointsofinterest = Pointsofinterest.new(pointsofinterest_params)

    respond_to do |format|
      if @pointsofinterest.save
        format.html { redirect_to @pointsofinterest, notice: 'Pointsofinterest was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pointsofinterest }
      else
        format.html { render action: 'new' }
        format.json { render json: @pointsofinterest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pointsofinterests/1
  # PATCH/PUT /pointsofinterests/1.json
  def update
    respond_to do |format|
      if @pointsofinterest.update(pointsofinterest_params)
        format.html { redirect_to @pointsofinterest, notice: 'Pointsofinterest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pointsofinterest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pointsofinterests/1
  # DELETE /pointsofinterests/1.json
  def destroy
    @pointsofinterest.destroy
    respond_to do |format|
      format.html { redirect_to pointsofinterests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pointsofinterest
      @pointsofinterest = Pointsofinterest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pointsofinterest_params
      params.require(:pointsofinterest).permit(:pointsofinterest_id, :geom)
    end
end
