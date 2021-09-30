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

ActiveRecord::Schema.define(version: 2021_09_28_153001) do

  create_table "invoices", force: :cascade do |t|
    t.string "client_name", null: false
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "tax", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_name"], name: "index_invoices_on_client_name", unique: true
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.string "client_name", null: false
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "tax", precision: 10, scale: 2
    t.string "vendor", null: false
    t.integer "status", null: false
    t.integer "invoice_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_purchase_orders_on_invoice_id"
  end

  add_foreign_key "purchase_orders", "invoices"
end
