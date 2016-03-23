class Status < ActiveRecord::Base

	validates :start_date, presence: true
	validates :type,       presence: true
	enum      type: { alert: 0, closure: 1 }

end
