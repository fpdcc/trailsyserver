class Alert < ActiveRecord::Base

	has_many :alertings
	has_many :trail_systems, :through => :alertings, :source => :alertable,
  	:source_type => 'TrailSystem'
	has_many :pointsofinterests, :through => :alertings, :source => :alertable,
  	:source_type => 'Pointsofinterest'
  has_many :trail_subtrails, :through => :alertings, :source => :alertable,
    :source_type => 'TrailSubtrail'
  has_one :user, foreign_key: :id, primary_key: :created_by

  accepts_nested_attributes_for :alertings
  attr_accessor :latitude, :longitude
  #attr_accessor :alertings_attributes
  #attr_accessor :alertable_ids, :alertable_type, :starts_at, :ends_at
  attr_accessor :div_id
  attr_accessor :poi

  validates :alert_type,       presence: true
	enum      alert_type: { alert: 0, closure: 1 }
  validates :description, presence: true
  validates :starts_at, presence: true

	validates :link, format: { with: URI.regexp }, allow_blank: true
  validate :end_date_is_after_start_date
  validate :no_overlap_closures, if: :closure?

  def full_desc
    new_desc = description
    trail_systems = self.trail_systems
    if trail_systems.count > 0
      trail_systems.each do |trail_system|
        new_desc += " on #{trail_system.name}"
        subtrails = self.trail_subtrails.where(trail_subsystem: trail_system)
        if subtrails.count > 0
          new_desc += " - "
          new_desc += subtrails.pluck(:subtrail_name).to_sentence
        end
      end
      pois = self.pointsofinterests
      if pois.count > 0
        new_desc += " near "
        new_desc += pois.pluck(:name).to_sentence
      end
    end
    
    if link.present?
      new_desc += " #{link}"
    end
    new_desc
  end

  def self.poi_options_level1
    options = {}
    options['CLOSED: ice/snow'] = {alert_type: 'closure', description: 'Parking area closed due to ice and/or snow.'}
    options['CLOSED: flooding'] = {alert_type: 'closure', description: 'Parking area closed due to flooding.'}
    options['CLOSED: storm debris'] = {alert_type: 'closure', description: 'Parking area closed due to storm debris.'}
    options['CLOSED: weather'] = {alert_type: 'closure', description: 'Parking area closed due to weather.'}
    options['OPEN: sledding'] = {alert_type: 'alert', description: 'Sledding hill currently open. Hours & contact info: http://fpdcc.com/sledding-coasting/'}
    options['OPEN: snowmobile'] = {alert_type: 'alert', description: 'Snowmobile area currently open. Hours & contact info: http://fpdcc.com/snowmobiling/'}
    return options
  end

  def self.poi_options_level2
    options = {}
    options['CLOSED: land management'] = {alert_type: 'closure', description: 'Closed for land management.'}
    options['CLOSED: other'] = {alert_type: 'closure', description: ''}
    options['marking hazardous trees'] = {alert_type: 'alert', description: 'Hazardous trees and those impacted by the Emerald Ash Borer are being marked for removal in this area.'}
    options['removing hazardous trees'] = {alert_type: 'alert', description: 'Hazardous trees and those impacted by the Emerald Ash Borer are being removed in this area.'}
    options['prescribed burn'] = {alert_type: 'alert', description: 'Prescribed burn in the area.'}
    options['other alert'] = {alert_type: 'alert', description: ''}
    return options
  end

  def self.trail_options
    options = {}
    options['flooding'] = {alert_type: 'alert', description: 'Flooding '}
    options['tree down/storm debris'] = {alert_type: 'alert', description: 'Tree down/storm debris '}
    options['marking hazardous trees'] = {alert_type: 'alert', description: 'Hazardous trees and those impacted by the Emerald Ash Borer are being marked for removal '}
    options['removing hazardous trees'] = {alert_type: 'alert', description: 'Hazardous trees and those impacted by the Emerald Ash Borer are being removed '}
    options['other alert'] = {alert_type: 'alert', description: ''}
    return options
  end

  def self.poi_closed_options
    options = ['ice and/or snow', 'flooding', 'storm debris', 'weather']
  end

  def self.poi_closed_options_level2
    options = ['other']
    return Alert.poi_closed_options + options
  end

  def self.poi_open_options
    options = ['sledding', 'snowmobile']
  end

   def self.poi_open_options_level2
    options = ['marking hazardous trees', 'removing hazardous trees', 'prescribed burn', 'other']
    return Alert.poi_open_options + options
  end

  #validates :starts_at, presence: true
  def end_date_is_after_start_date
    return if ends_at.blank? || starts_at.blank?

    if ends_at < starts_at
      errors.add(:ends_at, "cannot be before the start date") 
    end 
  end

  def no_overlap_closures
    error_text = ''
    self.pointsofinterests.each do |poi|
      if poi.closed?
        errors.add(:poi, "#{poi.name} is already closed.")
      end
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
