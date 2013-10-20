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

ActiveRecord::Schema.define(version: 20131020182040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: true do |t|
    t.integer  "item_id",     null: false
    t.string   "color",       null: false
    t.integer  "amount",      null: false
    t.boolean  "reserve_met", null: false
    t.datetime "timestamp",   null: false
    t.integer  "external_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["external_id"], name: "index_bids_on_external_id", unique: true, using: :btree
  add_index "bids", ["item_id"], name: "index_bids_on_item_id", using: :btree

  create_table "items", force: true do |t|
    t.boolean  "reserve_met",     null: false
    t.integer  "estimate"
    t.string   "title",           null: false
    t.string   "description"
    t.datetime "ends_at",         null: false
    t.datetime "published_at",    null: false
    t.integer  "transport_price"
    t.boolean  "watched",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
