namespace :alert do
	desc "Populate Alert Origin Type if null"
	task :add_origin_type => :environment do
		Alert.where(origin_type: nil).find_each do |alert|
			if alert.alert_type == 'global'
				alert.origin_type = 'Global'
			else
				alert.origin_type = alert.trail_systems.present? ? 'TrailSystem' : 'Pointsofinterest'
			end
			if alert.save
				p "Alert #{alert.id} saved"
			else
				p "Destroying Alert #{alert.id}"
				alert.destroy
			end
		end
	end
end