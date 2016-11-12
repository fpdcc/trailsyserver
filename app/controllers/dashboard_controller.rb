class DashboardController < ApplicationController
  def poi
  	@pointsofinterests = Pointsofinterest.all
  	# @new_alertings = []
    # @pointsofinterests.length.times do
    #   @new_alertings << Alerting.new
    # end

  end

  def trail

  end
end
