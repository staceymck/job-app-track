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

ActiveRecord::Schema.define(version: 20210201150739) do

  create_table "follow_ups", force: :cascade do |t|
    t.string  "action"
    t.date    "complete_by"
    t.integer "action_status", default: 0
    t.integer "job_app_id"
  end

  add_index "follow_ups", ["action_status"], name: "index_follow_ups_on_action_status"

  create_table "job_apps", force: :cascade do |t|
    t.string  "job_title"
    t.string  "job_description"
    t.string  "company_name"
    t.string  "company_location"
    t.string  "contact_name"
    t.string  "contact_title"
    t.string  "contact_phone"
    t.string  "contact_email"
    t.date    "date_applied"
    t.integer "app_status",       default: 0
    t.integer "offer_decision",   default: 0
    t.text    "notes"
    t.integer "user_id"
  end

  add_index "job_apps", ["app_status"], name: "index_job_apps_on_app_status"

  create_table "users", force: :cascade do |t|
    t.string "username",        null: false
    t.string "password_digest"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
