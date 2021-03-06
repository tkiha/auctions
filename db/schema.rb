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

ActiveRecord::Schema.define(version: 20151107234209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.string   "name",                              null: false
    t.text     "description"
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "min_price"
    t.datetime "deadline_date"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "successful_bid_id"
    t.boolean  "closed",            default: false
  end

  add_index "auctions", ["product_id"], name: "index_auctions_on_product_id", using: :btree
  add_index "auctions", ["successful_bid_id"], name: "index_auctions_on_successful_bid_id", using: :btree
  add_index "auctions", ["user_id"], name: "index_auctions_on_user_id", using: :btree

  create_table "bids", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "auction_id"
    t.integer  "price",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "bids", ["auction_id"], name: "index_bids_on_auction_id", using: :btree
  add_index "bids", ["user_id", "auction_id"], name: "index_bids_on_user_id_and_auction_id", unique: true, using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "bid_id",     null: false
    t.string   "evaluation", null: false
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "comments", ["bid_id"], name: "index_comments_on_bid_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name",                                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "auctions", "products"
  add_foreign_key "auctions", "users"
  add_foreign_key "bids", "auctions"
  add_foreign_key "bids", "users"
  add_foreign_key "comments", "bids"
  add_foreign_key "comments", "users"
  add_foreign_key "products", "users"
end
