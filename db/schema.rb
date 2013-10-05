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

ActiveRecord::Schema.define(version: 20131005072650) do

  create_table "admins", force: true do |t|
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
    t.string   "userName"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "streetAddress"
    t.string   "city"
    t.string   "town"
    t.string   "contactNumber"
    t.string   "secContactNumber"
    t.string   "organization"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "isAdmin"
    t.boolean  "approved",               default: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "busstops", force: true do |t|
    t.string   "busStopName"
    t.string   "busStopLatLong"
    t.string   "busStopSecName"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_busstops", force: true do |t|
    t.integer  "route_id"
    t.integer  "busstop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "route_busstops", ["route_id", "busstop_id"], name: "index_route_busstops_on_route_id_and_busstop_id", unique: true

  create_table "routes", force: true do |t|
    t.string   "routeName"
    t.decimal  "routeDistance"
    t.string   "routeDestLatLong"
    t.decimal  "routeTravelTime"
    t.time     "routeStartTime"
    t.time     "routeStopTime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "routeSourceLatLong"
  end

  create_table "routes_busstops", force: true do |t|
    t.integer  "route_id"
    t.integer  "busstop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
