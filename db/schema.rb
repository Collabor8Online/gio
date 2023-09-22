# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_20_161457) do
  create_table "addresses", force: :cascade do |t|
    t.string "address", default: "", null: false
    t.integer "block_id"
    t.index ["block_id"], name: "index_addresses_on_block_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.string "range", default: "", null: false
    t.integer "location_id"
    t.index ["location_id"], name: "index_blocks_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "reference", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_locations_on_name"
    t.index ["reference"], name: "index_locations_on_reference"
  end

  add_foreign_key "addresses", "blocks"
  add_foreign_key "blocks", "locations"
end
