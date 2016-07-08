class TrailsInfo < ActiveRecord::Base
	self.primary_key = 'trail_info_id'
	belongs_to :new_trail, foreign_key: :trails_id, primary_key: :trails_id
end
