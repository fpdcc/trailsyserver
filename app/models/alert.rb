class Alert < ActiveRecord::Base

	has_many :alertings
	has_many :trail_systems, :through => :alertings, :source => :alertable,
  	:source_type => 'TrailSystem'
	has_many :pointsofinterests, :through => :alertings, :source => :alertable,
  	:source_type => 'Pointsofinterest'

  accepts_nested_attributes_for :alertings
  attr_accessor :latitude, :longitude
  #attr_accessor :alertings_attributes
  #attr_accessor :alertable_ids, :alertable_type, :starts_at, :ends_at

  validates :alert_type,       presence: true
	enum      alert_type: { alert: 0, closure: 1 }

	validates :link, format: { with: URI.regexp }, allow_blank: true

  def self.closure_options
    ['Ice', 'Water', 'Earth', 'Wind', 'Fire']
  end

  #validates :starts_at, presence: true
  def end_date_is_after_start_date
    return if ends_at.blank? || starts_at.blank?

    if ends_at < starts_at
      errors.add(:ends_at, "cannot be before the start date") 
    end 
  end

  scope :active, -> {
      where('ends_at >= ? or (starts_at is not null and ends_at is null)', Time.now)
    }


end
