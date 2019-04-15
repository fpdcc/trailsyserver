json.array!(@trail_subtrails) do |trail_subtrail|
  json.extract! trail_subtrail, :subtrail_id, :subtrail_name, :tags, :trail_subsystem, :direction, :segment_type, :trail_color, :trail_type, :off_fpdcc, :trail_subsystem_id

  json.subtrail_length_mi trail_subtrail.length_mi

  json.hours1 trail_subtrail.trails_desc.hours1 if trail_subtrail.trails_desc.hours1.present?
  json.hours2 trail_subtrail.trails_desc.hours2 if trail_subtrail.trails_desc.hours2.present?
  json.season1 trail_subtrail.trails_desc.season1 if trail_subtrail.trails_desc.season1.present?
  json.season2 trail_subtrail.trails_desc.season2 if trail_subtrail.trails_desc.season2.present?

  json.special_hours trail_subtrail.trails_desc.special_hours if trail_subtrail.trails_desc.special_hours.present?

  json.trail_desc trail_subtrail.trails_desc.trail_desc if trail_subtrail.trails_desc.trail_desc.present?

  json.map_link trail_subtrail.trails_desc.map_link if trail_subtrail.trails_desc.map_link.present?

  json.map_link_spanish trail_subtrail.trails_desc.map_link_spanish if trail_subtrail.trails_desc.map_link_spanish.present?

  json.alt_name trail_subtrail.trails_desc.alt_name if trail_subtrail.trails_desc.alt_name.present?

end
