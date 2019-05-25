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

ActiveRecord::Schema.define(version: 2019_05_25_033453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.decimal "price"
    t.integer "num_attendees", default: 0
    t.text "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vacation_id"
    t.bigint "user_id"
    t.date "cutoff_date"
    t.integer "no_of_days", default: 1
    t.string "type", null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
    t.index ["vacation_id"], name: "index_activities_on_vacation_id"
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "price"
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "activity_id"
    t.bigint "user_id"
    t.index ["activity_id"], name: "index_user_activities_on_activity_id"
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dwolla_token"
    t.string "first_name"
    t.string "last_name"
    t.string "dwolla_id"
    t.string "dwolla_funding_source"
  end

  create_table "vacation_users", force: :cascade do |t|
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "vacation_id"
    t.index ["user_id"], name: "index_vacation_users_on_user_id"
    t.index ["vacation_id"], name: "index_vacation_users_on_vacation_id"
  end

  create_table "vacations", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activities", "users"
  add_foreign_key "activities", "vacations"
  add_foreign_key "user_activities", "activities"
  add_foreign_key "user_activities", "users"
  add_foreign_key "vacation_users", "users"
  add_foreign_key "vacation_users", "vacations"
end
