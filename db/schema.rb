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

ActiveRecord::Schema.define(version: 2021_05_30_205934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_models", force: :cascade do |t|
    t.decimal "year"
    t.decimal "price", precision: 19, scale: 2
    t.decimal "cost_price", precision: 19, scale: 2
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "car_parts", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.boolean "defective"
    t.string "part_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_car_parts_on_car_id"
  end

  create_table "cars", force: :cascade do |t|
    t.bigint "car_model_id", null: false
    t.string "state"
    t.string "location"
    t.integer "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_model_id"], name: "index_cars_on_car_model_id"
  end

  create_table "computers", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_computers_on_car_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.bigint "car_model_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_orders_on_car_id"
    t.index ["car_model_id"], name: "index_orders_on_car_model_id"
  end

  add_foreign_key "car_parts", "cars", on_delete: :cascade
  add_foreign_key "cars", "car_models"
  add_foreign_key "computers", "cars", on_delete: :cascade
  add_foreign_key "orders", "car_models"
  add_foreign_key "orders", "cars"
end
