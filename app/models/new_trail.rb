class NewTrail < ActiveRecord::Base
	self.primary_key = 'trails_id'
	has_one :trails_info, foreign_key: :trails_id, primary_key: :trails_id
end
