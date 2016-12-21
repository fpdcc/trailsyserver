class DashboardController < ApplicationController
  before_action :authenticate_user!

  def poi
  	@pointsofinterests_active = Pointsofinterest.with_current_or_future_alerts #.order(self.active_alerts_count)
  	
    query = ""
    if params[:name].present?
      query = "name ILIKE ?", "#{params[:name]}%"
    end
    @pointsofinterests = Pointsofinterest.paginate(page: params[:page]).includes(:alertings).where(query)
    #@status = Status.new
    #@alert = Alert.new
    #@alert.alertings.build
  	# @new_alertings = []
    # @pointsofinterests.length.times do
    #   @new_alertings << Alerting.new
    # end

  end

  def trail
    @trails_active = TrailSystem.with_current_or_future_alerts
    query = ""
    if params[:trail_subsystem].present?
      query = "trail_subsystem ILIKE ?", "#{params[:trail_subsystem]}%"
    end
    @trails = TrailSystem.all.paginate(page: params[:page]).where(query)
  end
end
