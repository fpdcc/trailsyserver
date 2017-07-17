require 'active_support/concern'

module Alertable

  extend ActiveSupport::Concern

  attr_accessor :current_alerts_count

  def current_alerts_count
  	self.alerts.current.count
  end


  included do
    scope :closed, -> { joins(:alerts).merge(Alert.closure.current).group(:id)}
  	scope :with_current_alerts, -> { joins(:alerts).merge(Alert.current).group(:id) }
  	scope :with_current_or_near_future_alerts, -> { joins(:alerts).merge(Alert.current_or_near_future).group(:id) }
    scope :with_future_alerts, -> { joins(:alerts).merge(Alert.future).group(:id) }
  	# scope :with_current_or_future_alerts,  -> { joins(:alerts).merge(Alert.current_or_future)}
  end

  def closed?
  	self.alerts.closure.current.count > 0
  end

  def current_alerts_count
  	self.alerts.current.count
  end



  # def current_alerts_count
  # 	self.alert.current.count
  # end

  def future_alerts_count
  	self.alert.future.count
  end



  def self.with_active_alerts

  end
end
