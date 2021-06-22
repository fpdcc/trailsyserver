if @global
	json.global do
		json.array!(@global) do |alert|
			json.id alert.id
			json.alert_type alert.alert_type
			json.origin_type alert.origin_type
			json.start_date alert.starts_at.try(:strftime, "%m/%d/%Y")
			json.end_date alert.ends_at.try(:strftime, "%m/%d/%Y")
			json.description alert.full_desc
			json.link alert.link
		end
	end
end

json.locations do
	json.array!(@locations) do |pointsofinterest|
		# json.array! pointsofinterest do
			json.extract! pointsofinterest, :id, :name
			json.map_id pointsofinterest.map_id
			json.type pointsofinterest.type
			json.web_link pointsofinterest.web_link
			json.alerts pointsofinterest.alerts.current_or_near_future do |alert|
				json.cache! alert do
					json.id alert.id
					json.alert_type alert.alert_type
					json.origin_type alert.origin_type
					json.start_date alert.starts_at.try(:strftime, "%m/%d/%Y")
					json.end_date alert.ends_at.try(:strftime, "%m/%d/%Y")
					json.description alert.full_desc
					json.link alert.link
				end
			end
		# end
	end
end
