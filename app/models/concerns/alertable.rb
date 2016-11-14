require 'active_support/concern'

module Alertable

  extend ActiveSupport::Concern


  def active_alerts_count
  	self.alertings.active.count
  end

  def self.with_active_alerts

  end
end
