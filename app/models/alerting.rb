class Alerting < ActiveRecord::Base

	belongs_to :alert

	# Yes, but we want higher level users to be able to create alert when creating alerting
	validates  :alert, presence: true

  	belongs_to :alertable, :polymorphic => true
  	validates  :alertable, presence: true

  	validates :alertable_type, presence: true
  	validates :alertable_id, presence: true
  	validates :alert_id, presence: true
  	validates :starts_at, presence: true

end
