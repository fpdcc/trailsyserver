json.extract! @trail_system, :id, :trail_subsystem #, :created_at, :updated_at

json.alerts do
    json.array!(@alerts) do |alert|
        json.extract! alert, :id, :alert_type, :origin_type, :link
    
        json.description alert.full_desc
    
        json.start_date alert.starts_at.try(:strftime, "%m/%d/%Y")
        json.end_date alert.ends_at.try(:strftime, "%m/%d/%Y")
    
        # Nested trail_system
        #json.trail_systems alert.trail_systems.pluck(:trail_subsystem)
    
        # Nested pointsofinterest
        #json.pointsofinterests alert.pointsofinterests.ids
        
    end
end
    
