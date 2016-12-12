# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161212194855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "activities", force: :cascade do |t|
    t.string    "activities_id"
    t.string    "nameid"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "atype"
    t.string    "aname"
    t.integer   "poi_info_id"
    t.integer   "trail_info_id"
    t.integer   "parking_info_id"
    t.geography "geom",            limit: {:srid=>4326, :type=>"point", :geographic=>true}
  end

  add_index "activities", ["activities_id"], name: "index_activities_on_activities_id", unique: true, using: :btree
  add_index "activities", ["poi_info_id"], name: "index_activities_on_poi_info_id", using: :btree

  create_table "alertings", force: :cascade do |t|
    t.string   "alertable_type"
    t.integer  "alertable_id"
    t.integer  "alert_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "created_by"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "alerts", force: :cascade do |t|
    t.integer  "alert_id"
    t.integer  "alert_type"
    t.string   "description"
    t.string   "link"
    t.integer  "created_by"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "names", force: :cascade do |t|
    t.integer  "nameid"
    t.string   "name"
    t.integer  "old_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "names", ["nameid"], name: "index_names_on_nameid", unique: true, using: :btree

  create_table "new_trails", force: :cascade do |t|
    t.integer   "trails_id"
    t.geography "geom",       limit: {:srid=>4326, :type=>"line_string", :geographic=>true}
    t.datetime  "created_at",                                                                null: false
    t.datetime  "updated_at",                                                                null: false
  end

  add_index "new_trails", ["trails_id"], name: "index_new_trails_on_trails_id", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "code"
    t.string   "full_name"
    t.string   "phone"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "parking_entrance_infos", force: :cascade do |t|
    t.integer  "parking_entrance_id"
    t.string   "multi_entrance"
    t.string   "private_lot"
    t.integer  "lot"
    t.string   "zone_name"
    t.string   "area_name"
    t.string   "fpd_uid"
    t.string   "point_type"
    t.string   "parking_entrance_addr"
    t.string   "trailaccess"
    t.integer  "nameid"
    t.integer  "parking_info_id"
    t.string   "entrance_closed"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "parking_entrance_infos", ["parking_entrance_id"], name: "index_parking_entrance_infos_on_parking_entrance_id", unique: true, using: :btree
  add_index "parking_entrance_infos", ["parking_info_id"], name: "index_parking_entrance_infos_on_parking_info_id", unique: true, using: :btree

  create_table "parking_entrances", force: :cascade do |t|
    t.integer   "parking_entrance_id"
    t.geography "geom",                limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime  "created_at",                                                                   null: false
    t.datetime  "updated_at",                                                                   null: false
    t.integer   "nameid"
    t.string    "entrance_closed"
    t.integer   "parking_info_id"
    t.string    "name"
    t.string    "web_street_addr"
    t.string    "web_muni_addr"
    t.string    "web_poi"
  end

  add_index "parking_entrances", ["parking_entrance_id"], name: "index_parking_entrances_on_parking_entrance_id", unique: true, using: :btree

  create_table "photorecords", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "name"
    t.integer  "trail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "credit"
  end

  create_table "picnicgroves", force: :cascade do |t|
    t.integer  "picnicgrove_id",                                      null: false
    t.string   "preserve_name"
    t.integer  "grove"
    t.string   "division"
    t.integer  "capacity"
    t.string   "large_capacity"
    t.string   "picnicgrove_type"
    t.string   "location"
    t.string   "status"
    t.string   "fpd_uid"
    t.integer  "poi_info_id"
    t.geometry "geom",             limit: {:srid=>0, :type=>"point"}
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "picnicgroves", ["picnicgrove_id"], name: "index_picnicgroves_on_picnicgrove_id", unique: true, using: :btree
  add_index "picnicgroves", ["status"], name: "index_picnicgroves_on_status", using: :btree

  create_table "poi_amenities", force: :cascade do |t|
    t.integer  "poi_info_id"
    t.integer  "ada"
    t.integer  "bike_parking"
    t.integer  "bike_rental"
    t.integer  "birding"
    t.integer  "boat_ramp"
    t.integer  "boat_rental"
    t.integer  "camping"
    t.integer  "canoe"
    t.integer  "comfortstation"
    t.integer  "cross_country"
    t.integer  "cycling"
    t.integer  "disc_golf"
    t.integer  "dog_friendly"
    t.integer  "dog_leash"
    t.integer  "drinkingwater"
    t.integer  "drone"
    t.integer  "ecological"
    t.integer  "equestrian"
    t.integer  "fishing"
    t.integer  "ice_fishing"
    t.integer  "gas_powered"
    t.integer  "golf"
    t.integer  "hiking"
    t.integer  "indoor_rental"
    t.integer  "large_capacity"
    t.integer  "m_airplane"
    t.integer  "m_boat"
    t.integer  "nature_center"
    t.integer  "natureplay"
    t.integer  "no_alcohol"
    t.integer  "no_parking"
    t.integer  "overlook"
    t.integer  "pavillion"
    t.integer  "picnic_grove"
    t.integer  "shelter"
    t.integer  "skating_ice"
    t.integer  "skating_inline"
    t.integer  "sledding"
    t.integer  "snowmobile"
    t.integer  "swimming"
    t.integer  "toboggan"
    t.integer  "volunteer"
    t.integer  "zip_line"
    t.integer  "poi_amenity_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "nature_preserve"
    t.integer  "no_fishing"
    t.integer  "public_building"
    t.integer  "driving_range"
  end

  add_index "poi_amenities", ["poi_amenity_id"], name: "index_poi_amenities_on_poi_amenity_id", unique: true, using: :btree
  add_index "poi_amenities", ["poi_info_id"], name: "index_poi_amenities_on_poi_info_id", unique: true, using: :btree

  create_table "poi_descs", force: :cascade do |t|
    t.integer  "poi_info_id"
    t.string   "hours1"
    t.string   "hours2"
    t.string   "phone"
    t.string   "description"
    t.string   "web_link"
    t.string   "map_link"
    t.string   "map_link_spanish"
    t.string   "vol_link"
    t.string   "vol_link2"
    t.string   "picnic_link"
    t.string   "event_link"
    t.string   "custom_link"
    t.string   "season1"
    t.string   "season2"
    t.string   "special_hours"
    t.string   "special_description"
    t.string   "special_link"
    t.string   "photo_link"
    t.integer  "poi_desc_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "poi_descs", ["poi_desc_id"], name: "index_poi_descs_on_poi_desc_id", unique: true, using: :btree
  add_index "poi_descs", ["poi_info_id"], name: "index_poi_descs_on_poi_info_id", unique: true, using: :btree

  create_table "poi_infos", force: :cascade do |t|
    t.integer  "poi_info_id"
    t.string   "point_type"
    t.string   "addr"
    t.string   "zip"
    t.string   "zipmuni"
    t.string   "municipality"
    t.string   "public_access"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.integer  "commdist"
    t.string   "zone_name"
    t.integer  "zonemapno"
    t.integer  "dwmapno"
    t.integer  "nameid"
    t.integer  "pointsofinterest_id"
    t.integer  "fpd_uid"
    t.string   "web_poi"
    t.string   "web_street_addr"
    t.string   "web_muni_addr"
    t.integer  "parking_connection_id"
    t.integer  "parking_info_id"
    t.integer  "alt_nameid"
    t.integer  "alt2_nameid"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "poi_infos", ["poi_info_id"], name: "index_poi_infos_on_poi_info_id", unique: true, using: :btree

  create_table "poi_to_trails", force: :cascade do |t|
    t.integer  "trail_info_id"
    t.integer  "poi_info_id"
    t.decimal  "distance"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "poi_to_trails", ["poi_info_id"], name: "index_poi_to_trails_on_poi_info_id", using: :btree
  add_index "poi_to_trails", ["trail_info_id"], name: "index_poi_to_trails_on_trail_info_id", using: :btree

  create_table "pointsofinterests", force: :cascade do |t|
    t.integer   "pointsofinterest_id"
    t.geography "geom",                  limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime  "created_at",                                                                     null: false
    t.datetime  "updated_at",                                                                     null: false
    t.integer   "poi_info_id"
    t.string    "point_type"
    t.string    "public_access"
    t.decimal   "latitude"
    t.decimal   "longitude"
    t.string    "web_poi"
    t.string    "web_street_addr"
    t.string    "web_muni_addr"
    t.integer   "parking_connection_id"
    t.integer   "parking_info_id"
    t.string    "alt_name"
    t.string    "alt2_name"
    t.string    "name"
    t.integer   "ada"
    t.integer   "bike_parking"
    t.integer   "bike_rental"
    t.integer   "birding"
    t.integer   "boat_ramp"
    t.integer   "boat_rental"
    t.integer   "camping"
    t.integer   "canoe"
    t.integer   "comfortstation"
    t.integer   "cross_country"
    t.integer   "cycling"
    t.integer   "disc_golf"
    t.integer   "dog_friendly"
    t.integer   "dog_leash"
    t.integer   "drinkingwater"
    t.integer   "drone"
    t.integer   "ecological"
    t.integer   "equestrian"
    t.integer   "fishing"
    t.integer   "ice_fishing"
    t.integer   "gas_powered"
    t.integer   "golf"
    t.integer   "hiking"
    t.integer   "indoor_rental"
    t.integer   "large_capacity"
    t.integer   "m_airplane"
    t.integer   "m_boat"
    t.integer   "nature_center"
    t.integer   "natureplay"
    t.integer   "no_alcohol"
    t.integer   "no_parking"
    t.integer   "overlook"
    t.integer   "public_building"
    t.integer   "picnic_grove"
    t.integer   "shelter"
    t.integer   "skating_ice"
    t.integer   "skating_inline"
    t.integer   "sledding"
    t.integer   "snowmobile"
    t.integer   "swimming"
    t.integer   "toboggan"
    t.integer   "volunteer"
    t.integer   "zip_line"
    t.integer   "nature_preserve"
    t.integer   "no_fishing"
    t.integer   "driving_range"
    t.string    "maintenance_div"
    t.integer   "pavilion"
  end

  add_index "pointsofinterests", ["pointsofinterest_id"], name: "index_pointsofinterests_on_pointsofinterest_id", unique: true, using: :btree

  create_table "statuses", force: :cascade do |t|
    t.integer  "status_type"
    t.string   "reason"
    t.string   "title"
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "statusable_type"
    t.string   "statusable_id"
    t.integer  "created_by"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "trail_systems", force: :cascade do |t|
    t.string   "trail_subsystem"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "trailheads", force: :cascade do |t|
    t.string   "name"
    t.integer  "steward_id"
    t.integer  "source_id"
    t.string   "trail1"
    t.string   "trail2"
    t.string   "trail3"
    t.string   "trail4"
    t.string   "trail5"
    t.string   "trail6"
    t.string   "parking"
    t.string   "drinkwater"
    t.string   "restrooms"
    t.string   "kiosk"
    t.string   "contactnum"
    t.point    "geom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "park"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "poi_type"
    t.text     "segment_ids",         default: [], array: true
    t.string   "trailhead_id"
    t.text     "trail_ids",           default: [], array: true
    t.integer  "large_capacity"
    t.integer  "gas_powered"
    t.integer  "boat_rental"
    t.integer  "picnic_grove"
    t.integer  "shelter"
    t.integer  "hiking"
    t.integer  "cycling"
    t.integer  "in_line_sk"
    t.integer  "cross_country"
    t.integer  "ecological"
    t.integer  "equestrian"
    t.integer  "birding"
    t.integer  "fishing"
    t.integer  "canoe"
    t.integer  "snowmobile"
    t.integer  "m_boat"
    t.integer  "m_airplace"
    t.integer  "camping"
    t.integer  "dog_friendly"
    t.integer  "sledding"
    t.integer  "toboggan_a"
    t.integer  "boat_ramp"
    t.integer  "nature_center"
    t.integer  "swimming"
    t.integer  "golf"
    t.integer  "no_alcohol"
    t.integer  "no_parking"
    t.integer  "comfortstation"
    t.integer  "drinkingwater"
    t.integer  "natureplay"
    t.integer  "ada"
    t.integer  "pavillion"
    t.integer  "trailacces"
    t.string   "hours1"
    t.string   "hours2"
    t.string   "phone"
    t.text     "description"
    t.string   "web_link"
    t.string   "map_link"
    t.string   "map_link_spanish"
    t.string   "vol_link"
    t.string   "vol_link2"
    t.string   "picnic_link"
    t.string   "event_link"
    t.string   "season1"
    t.string   "season2"
    t.string   "special_hours"
    t.string   "special_description"
    t.string   "special_link"
    t.string   "photo_link"
    t.integer  "bike_parking"
    t.integer  "bike_rental"
    t.integer  "disc_golf"
    t.integer  "dog_leash"
    t.integer  "drone"
    t.integer  "ice_fishing"
    t.integer  "indoor_rental"
    t.integer  "overlook"
    t.integer  "skating_ice"
    t.integer  "skating_inline"
    t.integer  "toboggan"
    t.integer  "volunteer"
    t.integer  "zip_line"
    t.string   "custom_link"
  end

  create_table "trails", force: :cascade do |t|
    t.string   "name"
    t.integer  "source_id"
    t.integer  "steward_id"
    t.decimal  "length"
    t.string   "accessible"
    t.string   "roadbike"
    t.string   "hike"
    t.string   "mtnbike"
    t.string   "equestrian"
    t.string   "xcntryski"
    t.string   "conditions"
    t.string   "trlsurface"
    t.string   "map_url"
    t.string   "dogs"
    t.text     "description"
    t.integer  "status",       default: 0
    t.string   "statustext"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "segment_ids",  default: [], array: true
    t.string   "trail_id"
    t.text     "part_of",      default: [], array: true
    t.string   "trail_system"
    t.string   "trail_color"
    t.string   "trail_type"
  end

  create_table "trails_descs", force: :cascade do |t|
    t.integer  "trail_desc_id",    null: false
    t.string   "trail_subsystem"
    t.string   "alt_name"
    t.string   "trail_desc"
    t.string   "map_link"
    t.string   "map_link_spanish"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "trails_descs", ["trail_desc_id"], name: "index_trails_descs_on_trail_desc_id", unique: true, using: :btree
  add_index "trails_descs", ["trail_subsystem"], name: "index_trails_descs_on_trail_subsystem", using: :btree

  create_table "trails_infos", force: :cascade do |t|
    t.string   "trail_system",        null: false
    t.string   "trail_subsystem",     null: false
    t.string   "trail_color"
    t.string   "trail_surface"
    t.string   "trail_type"
    t.string   "trail_difficulty"
    t.string   "regional_trail_name"
    t.string   "trail_desc"
    t.string   "gps"
    t.string   "comment"
    t.string   "alt_name"
    t.string   "cambr_name"
    t.string   "on_street"
    t.string   "crossing_type"
    t.string   "unrecognized",        null: false
    t.decimal  "length_mi"
    t.integer  "trails_id",           null: false
    t.string   "off_fpdcc",           null: false
    t.string   "web_trail",           null: false
    t.string   "maintenance"
    t.decimal  "length_ft"
    t.integer  "trail_info_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "direction"
  end

  add_index "trails_infos", ["trail_info_id"], name: "index_trails_infos_on_trail_info_id", unique: true, using: :btree
  add_index "trails_infos", ["trails_id"], name: "index_trails_infos_on_trails_id", using: :btree
  add_index "trails_infos", ["web_trail"], name: "index_trails_infos_on_web_trail", using: :btree

  create_table "trailsegments", force: :cascade do |t|
    t.integer   "source_id"
    t.integer   "steward_id"
    t.decimal   "length"
    t.string    "trail1"
    t.string    "trail2"
    t.string    "trail3"
    t.string    "trail4"
    t.string    "trail5"
    t.string    "trail6"
    t.string    "accessible"
    t.string    "roadbike"
    t.string    "hike"
    t.string    "mtnbike"
    t.string    "equestrian"
    t.string    "xcntryski"
    t.string    "conditions"
    t.string    "trlsurface"
    t.string    "dogs"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "segment_id"
    t.string    "foot"
    t.string    "bicycle"
    t.string    "horse"
    t.string    "ski"
    t.string    "wheelchair"
    t.string    "motor_vehicles"
    t.text      "trail_ids",                                                                          default: [], array: true
    t.text      "trail_names",                                                                        default: [], array: true
    t.text      "trail_systems",                                                                      default: [], array: true
    t.text      "trail_colors",                                                                       default: [], array: true
    t.text      "secondary_trail_ids",                                                                default: [], array: true
    t.geography "geom",                limit: {:srid=>4326, :type=>"line_string", :geographic=>true}
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.boolean  "approved",               default: false, null: false
    t.integer  "organization_id"
  end

  add_index "users", ["approved"], name: "index_users_on_approved", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
