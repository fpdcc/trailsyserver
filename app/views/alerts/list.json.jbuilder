json.array! @pointsofinterests do |pointsofinterest|
	json.extract! pointsofinterest, :id, :name
	json.map_id pointsofinterest.map_id
	json.type pointsofinterest.type
	json.alerts pointsofinterest.alerts.current_or_near_future do |alert|
		json.id alert.id
		json.alert_type alert.alert_type
		json.start_date alert.starts_at.try(:strftime, "%m/%d/%Y")
		json.end_date alert.ends_at.try(:strftime, "%m/%d/%Y")
		json.description alert.full_desc
	end

end


# json.question_cluster do
#   json.(@question_cluster)
#   json.questions @question_cluster.questions do |question|
#     json.id question.id
#     json.title question.title
#     json.required question.required
#     json.has_other question.has_other
#     json.position question.position
#     json.options question.options do |option|
#       json.id option.id
#       json.label option.label
#       json.value option.value
#       json.position option.position
#       json.go_page option.go_page
#     end
#   end
# end