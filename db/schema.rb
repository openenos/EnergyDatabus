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

ActiveRecord::Schema.define(version: 20150114084517) do

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "circuits", force: true do |t|
    t.boolean  "active"
    t.boolean  "input"
    t.string   "breaker_number"
    t.boolean  "double_breaker"
    t.integer  "breaker_size"
    t.string   "display"
    t.integer  "elec_load_type_id"
    t.integer  "panel_id"
    t.integer  "ct_sensor_type"
    t.boolean  "double_ct"
    t.string   "channel_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elec_load_types", force: true do |t|
    t.string   "load_type"
    t.string   "dispaly"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elec_meters", force: true do |t|
    t.string   "meter_type"
    t.string   "meter_main"
    t.string   "display"
    t.integer  "site_id"
    t.integer  "meter_loc"
    t.string   "phase"
    t.integer  "amp"
    t.integer  "volt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "geo_addr"
    t.integer  "postal_code_id"
    t.decimal  "geo_lat",        precision: 10, scale: 0
    t.decimal  "geo_lng",        precision: 10, scale: 0
    t.integer  "utility_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panels", force: true do |t|
    t.string   "emon_url"
    t.string   "equip_ref"
    t.string   "panel_type"
    t.integer  "parent_panel_id"
    t.integer  "site_id"
    t.integer  "no_of_circuits"
    t.integer  "amp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postal_codes", force: true do |t|
    t.string   "geo_postal_code"
    t.string   "geo_city"
    t.string   "geo_state"
    t.string   "geo_country"
    t.string   "tz"
    t.string   "weather_ref"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_group_mappings", force: true do |t|
    t.integer  "site_group_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_groups", force: true do |t|
    t.string   "display"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", force: true do |t|
    t.integer  "area_gross_square_foot"
    t.string   "site_ref"
    t.string   "display"
    t.integer  "year_built"
    t.integer  "area_cond_square_foot"
    t.integer  "operating_hours"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "utilities", force: true do |t|
    t.string   "display"
    t.string   "utility_type"
    t.float    "base_rate"
    t.boolean  "demand"
    t.float    "tier1_rate"
    t.float    "tier2_rate"
    t.float    "tier3_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
