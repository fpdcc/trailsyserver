json.array!(@trails_infos) do |trails_info|
  json.extract! trails_info, :id, :trail_system, :trail_subsystem, :trail_color, :trail_surface, :trail_type, :trail_difficulty, :regional_trail_name, :trail_desc, :gps, :comment, :alt_name, :cambr_name, :on_street, :crossing_type, :unrecognized, :length_mi, :trails_id, :off_fpdcc, :web_trail, :maintenance, :length_ft, :trail_info_id
  json.url trails_info_url(trails_info, format: :json)
end
