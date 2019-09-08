# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_08_002725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hang_participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hang_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hang_id"], name: "index_hang_participants_on_hang_id"
    t.index ["user_id", "hang_id"], name: "index_hang_participants_on_user_id_and_hang_id", unique: true
    t.index ["user_id"], name: "index_hang_participants_on_user_id"
  end

  create_table "hang_subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hang_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hang_type_id"], name: "index_hang_subscriptions_on_hang_type_id"
    t.index ["user_id", "hang_type_id"], name: "index_hang_subscriptions_on_user_id_and_hang_type_id", unique: true
    t.index ["user_id"], name: "index_hang_subscriptions_on_user_id"
  end

  create_table "hang_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hangs", force: :cascade do |t|
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.bigint "owner_id", null: false
    t.bigint "hang_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hang_type_id"], name: "index_hangs_on_hang_type_id"
    t.index ["owner_id"], name: "index_hangs_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "hang_participants", "hangs"
  add_foreign_key "hang_participants", "users"
  add_foreign_key "hang_subscriptions", "hang_types"
  add_foreign_key "hang_subscriptions", "users"
  add_foreign_key "hangs", "hang_types"
  add_foreign_key "hangs", "users", column: "owner_id"
end
