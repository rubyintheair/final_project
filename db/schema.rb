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

ActiveRecord::Schema.define(version: 20170905134606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cashflow_types", force: :cascade do |t|
    t.string "trend"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type_new"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_cashflows", force: :cascade do |t|
    t.integer "amount"
    t.text "stories"
    t.datetime "occur_at"
    t.bigint "user_id"
    t.bigint "friend_id"
    t.bigint "purpose_id"
    t.bigint "cashflow_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["cashflow_type_id"], name: "index_daily_cashflows_on_cashflow_type_id"
    t.index ["friend_id"], name: "index_daily_cashflows_on_friend_id"
    t.index ["purpose_id"], name: "index_daily_cashflows_on_purpose_id"
    t.index ["user_id"], name: "index_daily_cashflows_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.string "name"
    t.integer "friend_years"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purposes", force: :cascade do |t|
    t.string "purpose_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.integer "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "daily_cashflows", "cashflow_types"
  add_foreign_key "daily_cashflows", "friends"
  add_foreign_key "daily_cashflows", "purposes"
  add_foreign_key "daily_cashflows", "users"
end
