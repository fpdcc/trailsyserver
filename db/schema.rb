# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190116214651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "activities_id"
    t.string "nameid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "atype"
    t.string "aname"
    t.string "poi_info_id"
    t.integer "trail_info_id"
    t.integer "parking_info_id"
    t.geography "geom", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.index ["activities_id"], name: "index_activities_on_activities_id", unique: true
    t.index ["poi_info_id"], name: "index_activities_on_poi_info_id"
    t.index ["trail_info_id"], name: "index_activities_on_trail_info_id"
  end

  create_table "alertings", id: :serial, force: :cascade do |t|
    t.string "alertable_type"
    t.string "alertable_id"
    t.integer "alert_id"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_alertings_on_alert_id"
    t.index ["alertable_id"], name: "index_alertings_on_alertable_id"
  end

  create_table "alerts", id: :serial, force: :cascade do |t|
    t.integer "alert_id"
    t.integer "alert_type"
    t.string "description"
    t.string "link"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.geography "geom", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "reason"
    t.integer "origin_type"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "new_trails", id: :serial, force: :cascade do |t|
    t.integer "trails_id"
    t.geography "geom", limit: {:srid=>4326, :type=>"line_string", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trails_id"], name: "index_new_trails_on_trails_id", unique: true
  end

  create_table "organizations", id: :serial, force: :cascade do |t|
    t.string "code"
    t.string "full_name"
    t.string "phone"
    t.string "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "parking_entrances", id: :serial, force: :cascade do |t|
    t.integer "parking_entrance_id"
    t.geography "geom", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "nameid"
    t.string "entrance_closed"
    t.integer "parking_info_id"
    t.string "name"
    t.string "web_street_addr"
    t.string "web_muni_addr"
    t.string "web_poi"
    t.index ["parking_entrance_id"], name: "index_parking_entrances_on_parking_entrance_id", unique: true
  end

  create_table "photorecords", id: :serial, force: :cascade do |t|
    t.integer "source_id"
    t.string "name"
    t.integer "trail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "credit"
  end

  create_table "picnicgroves", id: :serial, force: :cascade do |t|
    t.integer "picnicgrove_id", null: false
    t.string "preserve_name"
    t.integer "grove"
    t.string "division"
    t.integer "capacity"
    t.string "large_capacity"
    t.string "location"
    t.string "status"
    t.string "fpd_uid"
    t.string "poi_info_id"
    t.geometry "geom", limit: {:srid=>0, :type=>"st_point"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "grove_type"
    t.index ["picnicgrove_id"], name: "index_picnicgroves_on_picnicgrove_id", unique: true
    t.index ["poi_info_id"], name: "index_picnicgroves_on_poi_info_id"
    t.index ["status"], name: "index_picnicgroves_on_status"
  end

  create_table "poi_descs", id: :serial, force: :cascade do |t|
    t.string "poi_info_id"
    t.string "hours1"
    t.string "hours2"
    t.string "phone"
    t.string "description"
    t.string "web_link"
    t.string "map_link"
    t.string "map_link_spanish"
    t.string "vol_link"
    t.string "vol_link2"
    t.string "picnic_link"
    t.string "event_link"
    t.string "custom_link"
    t.string "season1"
    t.string "season2"
    t.string "special_hours"
    t.string "special_description"
    t.string "special_link"
    t.string "photo_link"
    t.integer "poi_desc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fish_map"
    t.index ["poi_desc_id"], name: "index_poi_descs_on_poi_desc_id", unique: true
    t.index ["poi_info_id"], name: "index_poi_descs_on_poi_info_id", unique: true
  end

  create_table "pointsofinterests", id: :serial, force: :cascade do |t|
    t.integer "pointsofinterest_id"
    t.geography "geom", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "poi_info_id"
    t.string "point_type"
    t.string "public_access"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "web_poi"
    t.string "web_street_addr"
    t.string "web_muni_addr"
    t.integer "parking_connection_id"
    t.integer "parking_info_id"
    t.string "alt_name"
    t.string "alt2_name"
    t.string "name"
    t.integer "ada"
    t.integer "bike_parking"
    t.integer "bike_rental"
    t.integer "birding"
    t.integer "boat_ramp"
    t.integer "boat_rental"
    t.integer "camping"
    t.integer "canoe"
    t.integer "comfortstation"
    t.integer "cross_country"
    t.integer "cycling"
    t.integer "disc_golf"
    t.integer "dog_friendly"
    t.integer "dog_leash"
    t.integer "drinkingwater"
    t.integer "drone"
    t.integer "ecological"
    t.integer "equestrian"
    t.integer "fishing"
    t.integer "ice_fishing"
    t.integer "gas_powered"
    t.integer "golf"
    t.integer "hiking"
    t.integer "indoor_rental"
    t.integer "large_capacity"
    t.integer "m_airplane"
    t.integer "m_boat"
    t.integer "nature_center"
    t.integer "natureplay"
    t.integer "no_alcohol"
    t.integer "no_parking"
    t.integer "overlook"
    t.integer "public_building"
    t.integer "picnic_grove"
    t.integer "shelter"
    t.integer "skating_ice"
    t.integer "skating_inline"
    t.integer "sledding"
    t.integer "snowmobile"
    t.integer "swimming"
    t.integer "toboggan"
    t.integer "volunteer"
    t.integer "zip_line"
    t.integer "nature_preserve"
    t.integer "no_fishing"
    t.integer "driving_range"
    t.string "maintenance_div"
    t.integer "pavilion"
    t.integer "recreation_center"
    t.integer "bathroom_building_winter"
    t.integer "bathroom_building_summer"
    t.integer "bathroom_building_ada"
    t.integer "bathroom_portable_winter"
    t.integer "bathroom_portable_summer"
    t.integer "bathroom_portable_ada"
    t.geography "web_map_geom", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "maintenance_div_nickname"
    t.integer "shower", default: 0
    t.integer "dining_hall", default: 0
    t.integer "sanitation_station", default: 0
    t.integer "camp_store", default: 0
    t.integer "no_dogs", default: 0
    t.index ["poi_info_id"], name: "index_pointsofinterests_on_poi_info_id", unique: true
    t.index ["pointsofinterest_id"], name: "index_pointsofinterests_on_pointsofinterest_id", unique: true
  end

  create_table "trail_subtrails", id: :serial, force: :cascade do |t|
    t.string "trail_subsystem", null: false
    t.string "trail_color"
    t.string "trail_type"
    t.string "segment_type"
    t.string "direction"
    t.string "off_fpdcc"
    t.string "subtrail_id"
    t.string "subtrail_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "length_mi"
    t.index ["subtrail_id"], name: "index_trail_subtrails_on_subtrail_id", unique: true
    t.index ["trail_subsystem"], name: "index_trail_subtrails_on_trail_subsystem"
  end

  create_table "trail_systems", id: :serial, force: :cascade do |t|
    t.string "trail_subsystem"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trail_subsystem"], name: "index_trail_systems_on_trail_subsystem", unique: true
  end

  create_table "trails", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "source_id"
    t.integer "steward_id"
    t.decimal "length"
    t.string "accessible"
    t.string "roadbike"
    t.string "hike"
    t.string "mtnbike"
    t.string "equestrian"
    t.string "xcntryski"
    t.string "conditions"
    t.string "trlsurface"
    t.string "map_url"
    t.string "dogs"
    t.text "description"
    t.integer "status", default: 0
    t.string "statustext"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "segment_ids", default: [], array: true
    t.string "trail_id"
    t.text "part_of", default: [], array: true
    t.string "trail_system"
    t.string "trail_color"
    t.string "trail_type"
  end

  create_table "trails_descs", id: :serial, force: :cascade do |t|
    t.integer "trail_desc_id", null: false
    t.string "trail_subsystem"
    t.string "alt_name"
    t.string "trail_desc"
    t.string "map_link"
    t.string "map_link_spanish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trail_desc_id"], name: "index_trails_descs_on_trail_desc_id", unique: true
    t.index ["trail_subsystem"], name: "index_trails_descs_on_trail_subsystem"
  end

  create_table "trails_infos", id: :serial, force: :cascade do |t|
    t.string "trail_system", null: false
    t.string "trail_subsystem", null: false
    t.string "trail_color"
    t.string "trail_surface"
    t.string "trail_type"
    t.string "trail_difficulty"
    t.string "regional_trail_name"
    t.string "trail_desc"
    t.string "gps"
    t.string "comment"
    t.string "alt_name"
    t.string "cambr_name"
    t.string "on_street"
    t.string "crossing_type"
    t.string "unrecognized", null: false
    t.decimal "length_mi"
    t.integer "trails_id", null: false
    t.string "off_fpdcc", null: false
    t.string "web_trail", null: false
    t.string "maintenance"
    t.decimal "length_ft"
    t.integer "trail_info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "direction"
    t.string "segment_type"
    t.string "direct_trail_id"
    t.string "direct_trail_name"
    t.index ["trail_info_id"], name: "index_trails_infos_on_trail_info_id", unique: true
    t.index ["trail_subsystem"], name: "index_trails_infos_on_trail_subsystem"
    t.index ["trails_id"], name: "index_trails_infos_on_trails_id"
    t.index ["web_trail"], name: "index_trails_infos_on_web_trail"
  end

  create_table "updates", id: :serial, force: :cascade do |t|
    t.string "filename"
    t.text "updatedata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "job"
    t.integer "created_by"
    t.integer "approved_by"
    t.boolean "approved", default: false
    t.datetime "run_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "admin", default: false
    t.boolean "approved", default: false, null: false
    t.integer "organization_id"
    t.integer "role"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.integer "transaction_id"
    t.text "object_changes"
    t.string "full_desc"
    t.string "pois"
    t.string "trails"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

end
