class Status < ActiveRecord::Base

	validates :start_date, presence: true
	validates :statusable_type, presence:true
	#enum      statusable_type: { entrance: 0, trail: 1 }
	validates :statusable_id, presence:true
	validates :status_type,       presence: true
	enum      status_type: { alert: 0, closure: 1 }

end
