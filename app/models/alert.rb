class Alert < ActiveRecord::Base

	  has_many :alertings, inverse_of: :alert
  	has_many :trail_infos, :through => :alertings, :source => :alertable,
    	:source_type => 'Trail'
  	has_many :pointsofinterests, :through => :alertings, :source => :alertable,
    	:source_type => 'Pointsofinterest'

    accepts_nested_attributes_for :alertings
    attr_accessor :alertings_attributes
    attr_accessor :alertable_ids, :alertable_type, :starts_at, :ends_at

    validates :alert_type,       presence: true
	enum      alert_type: { alert: 0, closure: 1 }

	validates :link, format: { with: URI.regexp }, allow_blank: true

end
