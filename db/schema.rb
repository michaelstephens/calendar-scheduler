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

ActiveRecord::Schema.define(version: 20140505192655) do

  create_table "assignments", force: true do |t|
    t.integer "human_id"
    t.string  "human_type"
    t.integer "role_id",    null: false
    t.string  "source"
  end

  add_index "assignments", ["human_id", "role_id"], name: "index_assignments_on_human_id_and_role_id"
  add_index "assignments", ["human_id"], name: "index_assignments_on_human_id"
  add_index "assignments", ["role_id"], name: "index_assignments_on_role_id"
  add_index "assignments", ["source"], name: "index_assignments_on_source"

  create_table "events", force: true do |t|
    t.string   "title"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string "name", null: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "email"
    t.string   "department"
    t.string   "photo_url"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.integer  "login_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["first_name", "last_name"], name: "index_users_on_first_name_and_last_name"
  add_index "users", ["first_name"], name: "index_users_on_first_name"
  add_index "users", ["last_name", "first_name"], name: "index_users_on_last_name_and_first_name"
  add_index "users", ["last_name"], name: "index_users_on_last_name"
  add_index "users", ["username"], name: "index_users_on_username"

end
