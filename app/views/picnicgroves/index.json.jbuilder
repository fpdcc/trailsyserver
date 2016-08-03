json.array!(@picnicgroves) do |picnicgrofe|
  json.extract! picnicgrofe, :id, :picnicgrove_id, :preserve_name, :grove, :division, :capacity, :large_capacity, :type, :location, :status, :fpd_uid, :poi_info_id, :geom
  json.url picnicgrofe_url(picnicgrofe, format: :json)
end
