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

ActiveRecord::Schema.define(version: 20220412005435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "most_recent_flights", force: :cascade do |t|
    t.integer  "timeframe"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turnpoints", force: :cascade do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.decimal  "radius"
    t.integer  "sort_order"
    t.string   "name"
    t.integer  "group_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "color"
    t.index ["group_id"], name: "index_turnpoints_on_group_id", using: :btree
  end

  create_table "user_groupings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "name"
    t.string   "in_reach_share_url"
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",                            default: false
    t.integer  "tracker_type",                     default: 0
    t.string   "spot_share_url"
    t.boolean  "tracking_enabled",                 default: true
    t.boolean  "accepted_terms_and_privacy",       default: false
    t.boolean  "custom_inreach_tracking_strategy", default: false
    t.integer  "lookback_duration",                default: 12
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "waypoints", force: :cascade do |t|
    t.string   "elevation"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "name"
    t.string   "text"
    t.string   "velocity"
    t.integer  "most_recent_flight_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.datetime "timestamp"
    t.index ["most_recent_flight_id"], name: "index_waypoints_on_most_recent_flight_id", using: :btree
  end

  add_foreign_key "turnpoints", "groups"
end
