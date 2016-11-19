class DashboardController < ApplicationController
  def poi
  	@pointsofinterests_active = Pointsofinterest.with_current_or_future_alerts #.order(self.active_alerts_count)
  	@pointsofinterests = Pointsofinterest.all.paginate(page: params[:page])
  	# @new_alertings = []
    # @pointsofinterests.length.times do
    #   @new_alertings << Alerting.new
    # end

  end

  def trail

  end
end
