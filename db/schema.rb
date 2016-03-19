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

ActiveRecord::Schema.define(version: 20160221032637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "activities", force: :cascade do |t|
    t.string    "activities_id",       limit: 255
    t.string    "activity_type",       limit: 255
    t.string    "name",                limit: 255
    t.string    "parking_entrance_id", limit: 255
    t.string    "nameid",              limit: 255
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.geography "geom",                limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.string    "trailhead_id",        limit: 255
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "code",              limit: 255
    t.string   "full_name",         limit: 255
    t.string   "phone",             limit: 255
    t.string   "url",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "photorecords", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "name",               limit: 255
    t.integer  "trail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "credit",             limit: 255
  end

  create_table "trailheads", force: :cascade do |t|
    t.string    "name",             limit: 255
    t.integer   "steward_id"
    t.integer   "source_id"
    t.string    "trail1",           limit: 255
    t.string    "trail2",           limit: 255
    t.string    "trail3",           limit: 255
    t.string    "trail4",           limit: 255
    t.string    "trail5",           limit: 255
    t.string    "trail6",           limit: 255
    t.string    "parking",          limit: 255
    t.string    "drinkwater",       limit: 255
    t.string    "restrooms",        limit: 255
    t.string    "kiosk",            limit: 255
    t.string    "contactnum",       limit: 255
    t.geography "geom",             limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "park",             limit: 255
    t.string    "address",          limit: 255
    t.string    "city",             limit: 255
    t.string    "state",            limit: 255
    t.string    "zip",              limit: 255
    t.string    "poi_type",         limit: 255
    t.text      "segment_ids",                                                               default: [], array: true
    t.string    "trailhead_id",     limit: 255
    t.text      "trail_ids",                                                                 default: [], array: true
    t.integer   "large_capacity"
    t.integer   "gas_powered"
    t.integer   "boat_rental"
    t.integer   "picnic_grove"
    t.integer   "shelter"
    t.integer   "hiking"
    t.integer   "cycling"
    t.integer   "in_line_sk"
    t.integer   "cross_country"
    t.integer   "ecological"
    t.integer   "equestrian"
    t.integer   "birding"
    t.integer   "fishing"
    t.integer   "canoe"
    t.integer   "snowmobile"
    t.integer   "m_boat"
    t.integer   "m_airplace"
    t.integer   "camping"
    t.integer   "dog_friendly"
    t.integer   "sledding"
    t.integer   "toboggan_a"
    t.integer   "boat_ramp"
    t.integer   "nature_center"
    t.integer   "swimming"
    t.integer   "golf"
    t.integer   "no_alcohol"
    t.integer   "no_parking"
    t.integer   "comfortstation"
    t.integer   "drinkingwater"
    t.integer   "natureplay"
    t.integer   "ada"
    t.integer   "pavillion"
    t.integer   "trailacces"
    t.string    "hours1",           limit: 255
    t.string    "hours2",           limit: 255
    t.string    "phone",            limit: 255
    t.text      "description"
    t.string    "web_link",         limit: 255
    t.string    "map_link",         limit: 255
    t.string    "map_link_spanish", limit: 255
    t.string    "vol_link",         limit: 255
    t.string    "vol_link2",        limit: 255
    t.string    "picnic_link",      limit: 255
    t.string    "event_link",       limit: 255
  end

  create_table "trails", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "source_id"
    t.integer  "steward_id"
    t.decimal  "length"
    t.string   "accessible",   limit: 255
    t.string   "roadbike",     limit: 255
    t.string   "hike",         limit: 255
    t.string   "mtnbike",      limit: 255
    t.string   "equestrian",   limit: 255
    t.string   "xcntryski",    limit: 255
    t.string   "conditions",   limit: 255
    t.string   "trlsurface",   limit: 255
    t.string   "map_url",      limit: 255
    t.string   "dogs",         limit: 255
    t.text     "description"
    t.integer  "status",                   default: 0
    t.string   "statustext",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "segment_ids",              default: [], array: true
    t.string   "trail_id",     limit: 255
    t.text     "part_of",                  default: [], array: true
    t.string   "trail_system", limit: 255
    t.string   "trail_color",  limit: 255
    t.string   "trail_type",   limit: 255
  end

  create_table "trailsegments", force: :cascade do |t|
    t.integer   "source_id"
    t.integer   "steward_id"
    t.decimal   "length"
    t.geography "geom",                limit: {:srid=>4326, :type=>"multi_line_string", :geographic=>true}
    t.string    "trail1",              limit: 255
    t.string    "trail2",              limit: 255
    t.string    "trail3",              limit: 255
    t.string    "trail4",              limit: 255
    t.string    "trail5",              limit: 255
    t.string    "trail6",              limit: 255
    t.string    "accessible",          limit: 255
    t.string    "roadbike",            limit: 255
    t.string    "hike",                limit: 255
    t.string    "mtnbike",             limit: 255
    t.string    "equestrian",          limit: 255
    t.string    "xcntryski",           limit: 255
    t.string    "conditions",          limit: 255
    t.string    "trlsurface",          limit: 255
    t.string    "dogs",                limit: 255
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "segment_id",          limit: 255
    t.string    "foot",                limit: 255
    t.string    "bicycle",             limit: 255
    t.string    "horse",               limit: 255
    t.string    "ski",                 limit: 255
    t.string    "wheelchair",          limit: 255
    t.string    "motor_vehicles",      limit: 255
    t.text      "trail_ids",                                                                                default: [], array: true
    t.text      "trail_names",                                                                              default: [], array: true
    t.text      "trail_systems",                                                                            default: [], array: true
    t.text      "trail_colors",                                                                             default: [], array: true
    t.text      "secondary_trail_ids",                                                                      default: [], array: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.boolean  "approved",                           default: false, null: false
    t.integer  "organization_id"
  end

  add_index "users", ["approved"], name: "index_users_on_approved", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
