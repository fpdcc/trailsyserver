class Alert < ActiveRecord::Base

	has_many :alertings
  	has_many :new_trails, :through => :alertings, :source => :alertable,
    	:source_type => 'Trail'
  	has_many :poi_infos, :through => :alertings, :source => :alertable,
    	:source_type => 'POI'

    validates :alert_type,       presence: true
	enum      alert_type: { alert: 0, closure: 1 }

	validates :link, format: { with: URI.regexp }, allow_blank: true

end
