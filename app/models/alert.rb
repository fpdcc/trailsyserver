class Alert < ActiveRecord::Base

	has_many :alertings
	has_many :trail_systems, :through => :alertings, :source => :alertable,
  	:source_type => 'TrailSystem'
	has_many :pointsofinterests, :through => :alertings, :source => :alertable,
  	:source_type => 'Pointsofinterest'
  has_one :user, foreign_key: :id, primary_key: :created_by

  accepts_nested_attributes_for :alertings
  attr_accessor :latitude, :longitude
  #attr_accessor :alertings_attributes
  #attr_accessor :alertable_ids, :alertable_type, :starts_at, :ends_at

  validates :alert_type,       presence: true
	enum      alert_type: { alert: 0, closure: 1 }
  validates :description, presence: true

	validates :link, format: { with: URI.regexp }, allow_blank: true
  validate :end_date_is_after_start_date

  # validates :starts_at, :ends_at, if: :closure?, :overlap => {
  #   :scope => ["alerting.alertable_type", "alerting.alertable_id"], 
  #   :query_options => {:closure => nil}
  # }

  def self.closure_options
    options = ['ice and/or snow', 'flooding', 'storm debris', 'weather']
  end

  #validates :starts_at, presence: true
  def end_date_is_after_start_date
    return if ends_at.blank? || starts_at.blank?

    if ends_at < starts_at
      errors.add(:ends_at, "cannot be before the start date") 
    end 
  end

  default_scope { includes(:user).includes(:alertings) }

  scope :current_or_future, -> {
    where('ends_at >= ? or (starts_at is not null and ends_at is null)', Time.now)
  }

  scope :current, -> {
    where('starts_at <= ? and (ends_at >= ? or ends_at is null)', Time.now, Time.now)
  }

  scope :future, -> {
    where('starts_at > ?', Time.now)
  }

end
