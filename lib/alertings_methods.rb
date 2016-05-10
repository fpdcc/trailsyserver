# /lib/alertings_methods.rb
 
module AlertingsMethods
  # alerts_active: Current or future alerts (so where end_date is not in the past)
  def alerts_active
  	self.alertings.where("ends_at >= ? or ends_at is null", Time.now)
  end

  # alerts_current: Current alerts (start_date <= Time.now <= end_date)
  def alerts_current
    a = self.alertings.where("starts_at <= ? and (ends_at >= ? OR ends_at is null)", Time.now, Time.now)
  end

  # closure_current: Current closure (start_date <= Time.now <= end_date).
  # Should only be one of these.
  def closure_current
  	self.alerts_current.joins(:alert).where("alert_type = ?", Alert.alert_types[:closure])
  end


end