# /lib/alertings_methods.rb
 
module AlertingsMethods
  # alerts_active: Current or future alerts (so where end_date is not in the past)
  def alerts_active
    "hello"
  end

  # alerts_current: Current alerts (start_date <= Time.now <= end_date)
  def alerts_current
    "hello"
  end

  # closure_current: Current closure (start_date <= Time.now <= end_date).
  # Should only be one of these.
  def closure_current
    "hello"
  end


end