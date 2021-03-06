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

ActiveRecord::Schema.define(version: 20150930085234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stocks", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "ticker"
    t.string   "name"
    t.string   "last_price"
    t.string   "change"
    t.string   "change_percent"
    t.string   "timestamp"
    t.string   "market_cap"
    t.string   "volume"
    t.string   "start_value_ytd"
    t.string   "change_ytd"
    t.string   "high"
    t.string   "low"
    t.string   "open"
    t.string   "spy_chg_ytd"
    t.string   "lt_trend"
    t.string   "spy_daily_pct_chg"
    t.string   "st_trend"
    t.string   "recommendation"
  end

  create_table "user_stocks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "stock_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "quantity"
    t.string   "purchase_price"
    t.string   "spy_price"
    t.boolean  "purchased",      default: false
  end

  add_index "user_stocks", ["stock_id"], name: "index_user_stocks_on_stock_id", using: :btree
  add_index "user_stocks", ["user_id"], name: "index_user_stocks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "image_url"
  end

  add_foreign_key "user_stocks", "stocks"
  add_foreign_key "user_stocks", "users"
end
