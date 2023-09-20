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

ActiveRecord::Schema[7.0].define(version: 2023_09_06_171143) do
  create_table "accounts", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "field_data", size: :medium
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_accounts_on_status"
  end

  create_table "activities", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.binary "ancestry", limit: 3000
    t.string "object_type", null: false
    t.bigint "object_id", null: false
    t.bigint "subject_id", null: false
    t.string "type", null: false
    t.integer "status", default: 0, null: false
    t.text "description"
    t.text "field_data", size: :medium
    t.integer "ancestry_depth", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_activities_on_ancestry"
    t.index ["object_type", "object_id"], name: "index_activities_on_object"
    t.index ["subject_id"], name: "index_activities_on_subject_id"
    t.index ["type"], name: "index_activities_on_type"
  end

  create_table "activity_items", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.index ["activity_id"], name: "index_activity_items_on_activity_id"
    t.index ["item_type", "item_id"], name: "index_activity_items_on_item"
  end

  create_table "file_system_entries", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.binary "ancestry", limit: 3000
    t.string "container_type", null: false
    t.bigint "container_id", null: false
    t.string "contents_type"
    t.bigint "contents_id"
    t.string "type", null: false
    t.string "name", null: false
    t.string "attachment", default: "", null: false
    t.string "content_type", default: "", null: false
    t.integer "position", default: 1, null: false
    t.integer "status", default: 0, null: false
    t.text "description"
    t.text "field_data", size: :medium
    t.integer "ancestry_depth", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_file_system_entries_on_ancestry"
    t.index ["container_type", "container_id"], name: "index_file_system_entries_on_container"
    t.index ["contents_type", "contents_id"], name: "index_file_system_entries_on_contents"
    t.index ["name"], name: "index_file_system_entries_on_name"
    t.index ["type"], name: "index_file_system_entries_on_type"
  end

  create_table "groups", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "organisation_id", null: false
    t.text "field_data", size: :medium
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name"
    t.index ["organisation_id"], name: "index_groups_on_organisation_id"
    t.index ["status"], name: "index_groups_on_status"
  end

  create_table "groups_people", id: false, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "group_id", null: false
    t.index ["group_id"], name: "index_groups_people_on_group_id"
    t.index ["person_id"], name: "index_groups_people_on_person_id"
  end

  create_table "organisations", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "account_id", null: false
    t.text "field_data", size: :medium
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_organisations_on_account_id"
    t.index ["name"], name: "index_organisations_on_name"
    t.index ["status"], name: "index_organisations_on_status"
  end

  create_table "people", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "uid", null: false
    t.string "name", null: false
    t.string "password_ciphertext"
    t.string "text"
    t.integer "status", default: 0, null: false
    t.text "field_data", size: :medium
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_people_on_account_id"
    t.index ["name"], name: "index_people_on_name"
    t.index ["status"], name: "index_people_on_status"
  end

  create_table "triggers", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.bigint "account_id", null: false
    t.text "field_data", size: :medium
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_triggers_on_account_id"
    t.index ["status"], name: "index_triggers_on_status"
  end

  create_table "user_automations", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.bigint "account_id", null: false
    t.text "field_data", size: :medium
    t.integer "status", default: 0, null: false
    t.string "applies_to", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_user_automations_on_account_id"
    t.index ["status"], name: "index_user_automations_on_status"
  end

  add_foreign_key "activities", "people", column: "subject_id"
  add_foreign_key "activity_items", "activities"
  add_foreign_key "groups", "organisations"
  add_foreign_key "organisations", "accounts"
  add_foreign_key "people", "accounts"
  add_foreign_key "triggers", "accounts"
  add_foreign_key "user_automations", "accounts"
end
