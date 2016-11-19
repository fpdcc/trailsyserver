class Alerting < ActiveRecord::Base

	belongs_to :alert

	accepts_nested_attributes_for :alert

	attr_accessor :description, :alert_type, :link

	# Yes, but we want higher level users to be able to create alert when creating alerting
	validates  :alert, presence: true

  	belongs_to :alertable, :polymorphic => true
  	validates  :alertable, presence: true

  	validates :alertable_type, presence: true
  	validates :alertable_id, presence: true
  	validates :alert_id, presence: true
  	validates :starts_at, presence: true
  	validate :end_date_is_after_start_date

  	scope :current, lambda {
      where('starts_at <= ? and (ends_at >= ? or ends_at is null)', Time.now, Time.now)
    }

    scope :active, -> {
      where('ends_at >= ? or (starts_at is not null and ends_at is null)', Time.now)
    }

    scope :closure, -> { joins(:alert).where('alerts.alert_type = ?', 1).references(:alert)
 }

    validates :starts_at, :ends_at, if: :closure?, :overlap => {
    	:scope => ["alertable_type", "alertable_id"], 
    	:query_options => {:closure => nil}
    }

    def closure?
    	logger.info "in closure def"
    	if (alert.alert_type == 'closure')
    	  logger.info "closure true"
    	  return true
    	else
    	  logger.info "closure false"
    	  return false
    	end
    end


	#######
	private
	#######

	def end_date_is_after_start_date
	  return if ends_at.blank? || starts_at.blank?

	  if ends_at < starts_at
	    errors.add(:ends_at, "cannot be before the start date") 
	  end 
	end


  	#scope :alert_type, lambda {|alert_type| joins(:alerts).where('alerts.alert_type = ?', alert_type)}


  	#validates :alert, uniqueness: {scope: :alertable }, if: self.alert.closure?
  	#validate :only_one_current_closure
	#def only_one_current_closure
	#  if self.alert.closure?
	#  	current_closure_count = self.alertable.closure_current.count
	  # 	# use validates_overlap gem to check for other closures that overlap
	  # 	existing_closures = self.alertable.alertings.joins(:alert).where(
	  # 		#starts_at: ((Time.now - 1.day)..Time.now)
	  # 		:alerts => {:alert_type => 1})
	  # 	#:servers => {:company_id => 5})
	  # 	#existing_closures = Alertings.join(:alerts).where(alerts: {alert_type: "closure"})
	  # 	if existing_closures.present?
	  # 		errors.add(:base, "Error message: #{existing_closures[0].alert.alert_type}")
	  # 	end
	  # end
	  #posted = exists.where(user: user).where("DATE(created_at) = DATE(?)", Time.now)
	  #errors.add(:base, "Error message") if posted
	#end

end
