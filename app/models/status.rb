class Status < ActiveRecord::Base

	validates :start_date, presence: true
	validates :status_type,       presence: true
	enum      status_type: { alert: 0, closure: 1 }

end
