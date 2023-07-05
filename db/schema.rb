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

ActiveRecord::Schema[7.0].define(version: 2023_07_05_040744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.text "details"
    t.bigint "model_id", null: false
    t.bigint "brand_id", null: false
    t.bigint "user_id", null: false
    t.integer "distance"
    t.integer "max_luggage"
    t.integer "seat_count"
    t.string "case_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price", default: 0.0, null: false
    t.string "email"
    t.string "phone_number"
    t.string "user_name"
    t.string "user_surname"
    t.string "address"
    t.string "state"
    t.string "city"
    t.integer "model_year"
    t.integer "status", default: 0, null: false
    t.index ["brand_id"], name: "index_cars_on_brand_id"
    t.index ["model_id"], name: "index_cars_on_model_id"
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "stripe_credit_card_id"
    t.string "last_four_digits"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.bigint "brand_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_models_on_brand_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rents", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.bigint "renter_id", null: false
    t.bigint "owner_id", null: false
    t.datetime "start_date"
    t.datetime "finish_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "payment_intent_response", default: "{}"
    t.integer "payment_status", default: 0
    t.float "amount"
    t.string "payment_intent_id"
    t.jsonb "canceled_response"
    t.float "insurance"
    t.float "fee"
    t.index ["car_id"], name: "index_rents_on_car_id"
    t.index ["owner_id"], name: "index_rents_on_owner_id"
    t.index ["renter_id"], name: "index_rents_on_renter_id"
  end

  create_table "rules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stripe_accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "account_type"
    t.string "dob_month"
    t.string "dob_day"
    t.string "dob_year"
    t.string "phone"
    t.string "email"
    t.string "address_line"
    t.string "postal_code"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "account_id"
    t.index ["user_id"], name: "index_stripe_accounts_on_user_id"
  end

  create_table "stripe_customers", force: :cascade do |t|
    t.string "customer_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stripe_customers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_customer_id"
    t.string "mobile_number"
    t.string "adress"
    t.date "date_of_birth"
    t.string "name"
    t.string "surname"
    t.integer "document_status", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cars", "brands"
  add_foreign_key "cars", "models"
  add_foreign_key "cars", "users"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "models", "brands"
  add_foreign_key "rents", "cars"
  add_foreign_key "rents", "users", column: "owner_id"
  add_foreign_key "rents", "users", column: "renter_id"
  add_foreign_key "stripe_accounts", "users"
  add_foreign_key "stripe_customers", "users"
end
