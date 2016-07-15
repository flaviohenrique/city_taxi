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

ActiveRecord::Schema.define(version: 20160707233722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "map_blocks", force: :cascade do |t|
    t.integer  "row",        null: false
    t.integer  "col",        null: false
    t.integer  "map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "map_blocks", ["map_id"], name: "index_map_blocks_on_map_id", using: :btree

  create_table "maps", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "rows",       null: false
    t.integer  "cols",       null: false
    t.integer  "time",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "passengers", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "map_id"
    t.integer  "taxi_id"
    t.integer  "row",        null: false
    t.integer  "col",        null: false
    t.integer  "dest_row",   null: false
    t.integer  "dest_col",   null: false
    t.integer  "status",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "passengers", ["map_id"], name: "index_passengers_on_map_id", using: :btree
  add_index "passengers", ["taxi_id"], name: "index_passengers_on_taxi_id", using: :btree

  create_table "taxis", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "status",     null: false
    t.integer  "row",        null: false
    t.integer  "col",        null: false
    t.integer  "map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taxis", ["map_id"], name: "index_taxis_on_map_id", using: :btree

  add_foreign_key "map_blocks", "maps"
  add_foreign_key "passengers", "maps"
  add_foreign_key "passengers", "taxis"
  add_foreign_key "taxis", "maps"
end
