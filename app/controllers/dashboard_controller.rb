class DashboardController < ApplicationController
  def poi
  	@pointsofinterests_active = Pointsofinterest.with_active_alerts #.order(self.active_alerts_count)
  	@pointsofinterests_inactive = Pointsofinterest.no_active_alerts.paginate(page: params[:page])
  	# @new_alertings = []
    # @pointsofinterests.length.times do
    #   @new_alertings << Alerting.new
    # end

  end

  def trail

  end
end
