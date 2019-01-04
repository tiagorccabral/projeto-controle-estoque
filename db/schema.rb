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

ActiveRecord::Schema.define(version: 2019_01_04_145808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventory_categories", force: :cascade do |t|
    t.bigint "inventory_item_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_inventory_categories_on_category_id"
    t.index ["inventory_item_id"], name: "index_inventory_categories_on_inventory_item_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "responsible"
    t.string "area"
    t.string "acquisition_mode"
    t.string "conservation_state"
    t.string "serial_number"
    t.string "model"
    t.string "storage_location"
    t.integer "age", default: 0
    t.float "value", default: 0.0
    t.float "lifespan", default: 0.0
    t.float "current_value", default: 0.0
    t.float "depreciation", default: 0.0
    t.date "date_of_acquisition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.float "value"
    t.float "value_sold", default: 0.0
    t.integer "total_sold", default: 0
    t.string "donor", default: "Anônimo"
    t.string "receiver"
    t.boolean "internal", default: false
    t.datetime "entry_date"
    t.datetime "departure_date"
    t.boolean "used", default: false
    t.boolean "lost", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "observation"
    t.text "code"
  end

  create_table "time_charts", force: :cascade do |t|
    t.string "name"
    t.integer "amount_donated"
    t.float "value_donated"
    t.datetime "report_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
