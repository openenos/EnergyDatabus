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

ActiveRecord::Schema.define(version: 20150815060607) do

  create_table "accounts", force: :cascade do |t|
    t.string   "company_name",      limit: 255
    t.string   "company_reference", limit: 255
    t.integer  "user_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token", limit: 255
    t.integer  "client_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "circuits", force: :cascade do |t|
    t.boolean  "active"
    t.boolean  "input"
    t.string   "breaker_number",    limit: 255
    t.boolean  "double_breaker"
    t.integer  "breaker_size",      limit: 4
    t.string   "display",           limit: 255
    t.integer  "elec_load_type_id", limit: 4
    t.integer  "panel_id",          limit: 4
    t.integer  "ct_sensor_type",    limit: 4
    t.boolean  "double_ct"
    t.string   "channel_no",        limit: 255
    t.boolean  "is_producing"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",        limit: 4
  end

  create_table "elec_load_types", force: :cascade do |t|
    t.string   "load_type",  limit: 255
    t.string   "display",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elec_meters", force: :cascade do |t|
    t.string   "meter_type", limit: 255
    t.string   "meter_main", limit: 255
    t.string   "display",    limit: 255
    t.integer  "site_id",    limit: 4
    t.integer  "meter_loc",  limit: 4
    t.string   "phase",      limit: 255
    t.integer  "amp",        limit: 4
    t.integer  "volt",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id", limit: 4
  end

  create_table "locations", force: :cascade do |t|
    t.string   "geo_addr",       limit: 255
    t.integer  "postal_code_id", limit: 4
    t.decimal  "geo_lat",                    precision: 10
    t.decimal  "geo_lng",                    precision: 10
    t.integer  "utility_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",     limit: 4
  end

  create_table "panels", force: :cascade do |t|
    t.string   "emon_url",        limit: 255
    t.string   "equip_ref",       limit: 255
    t.string   "panel_type",      limit: 255
    t.integer  "parent_panel_id", limit: 4
    t.integer  "site_id",         limit: 4
    t.integer  "no_of_circuits",  limit: 4
    t.integer  "amp",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",      limit: 4
  end

  create_table "postal_codes", force: :cascade do |t|
    t.string   "geo_postal_code", limit: 255
    t.string   "geo_city",        limit: 255
    t.string   "geo_state",       limit: 255
    t.string   "geo_country",     limit: 255
    t.string   "tz",              limit: 255
    t.string   "weather_ref",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",      limit: 4
  end

  create_table "site_group_mappings", force: :cascade do |t|
    t.integer  "site_group_id", limit: 4
    t.integer  "site_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",    limit: 4
  end

  create_table "site_groups", force: :cascade do |t|
    t.string   "display",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id", limit: 4
  end

  create_table "sites", force: :cascade do |t|
    t.integer  "area_gross_square_foot", limit: 4
    t.string   "site_ref",               limit: 255
    t.string   "display",                limit: 255
    t.integer  "year_built",             limit: 4
    t.integer  "area_cond_square_foot",  limit: 4
    t.integer  "operating_hours",        limit: 4
    t.integer  "location_id",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",             limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",             limit: 4
    t.boolean  "is_admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "utilities", force: :cascade do |t|
    t.string   "display",      limit: 255
    t.string   "utility_type", limit: 255
    t.float    "base_rate",    limit: 24
    t.boolean  "demand"
    t.float    "tier1_rate",   limit: 24
    t.float    "tier2_rate",   limit: 24
    t.float    "tier3_rate",   limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
