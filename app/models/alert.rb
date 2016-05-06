class Alert < ActiveRecord::Base

	has_many :alertings
  	has_many :trails, :through => :alertings, :source => :alertable,
    	:source_type => 'Trail'
  	has_many :trailheads, :through => :alertings, :source => :alertable,
    	:source_type => 'Trailhead'

    validates :alert_type,       presence: true
	enum      alert_type: { alert: 0, closure: 1 }

	validates :link, format: { with: URI.regexp }, allow_blank: true

end
