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

ActiveRecord::Schema.define(version: 2020_11_11_180000) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "sender_id"
    t.integer "con_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "inquiry_id"
    t.index ["inquiry_id"], name: "index_conversations_on_inquiry_id"
    t.index ["recipient_id", "sender_id", "con_type"], name: "index_conversations_on_recipient_id_and_sender_id_and_con_type", unique: true
  end

  create_table "friend_requests", force: :cascade do |t|
    t.bigint "requester_id"
    t.bigint "requested_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["requested_id"], name: "index_friend_requests_on_requested_id"
    t.index ["requester_id"], name: "index_friend_requests_on_requester_id"
  end

  create_table "friendships", id: :serial, force: :cascade do |t|
    t.string "friendable_type"
    t.integer "friendable_id"
    t.integer "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "blocker_id"
    t.integer "status"
    t.index ["friendable_id", "friend_id"], name: "index_friendships_on_friendable_id_and_friend_id", unique: true
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "origin_location_type", null: false
    t.string "origin_country", null: false
    t.string "origin_address", null: false
    t.string "destination_location_type", null: false
    t.string "destination_country", null: false
    t.string "destination_address", null: false
    t.date "goods_ready_date", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "status", default: "Pending"
    t.decimal "origin_lat", precision: 10, scale: 6
    t.decimal "origin_lng", precision: 10, scale: 6
    t.decimal "destination_lat", precision: 10, scale: 6
    t.decimal "destination_lng", precision: 10, scale: 6
    t.index ["deleted_at"], name: "index_inquiries_on_deleted_at"
    t.index ["user_id"], name: "index_inquiries_on_user_id"
  end

  create_table "inquiry_items", force: :cascade do |t|
    t.string "commodity", null: false
    t.integer "number_of_units", null: false
    t.float "length", null: false
    t.float "width", null: false
    t.float "heigth", null: false
    t.float "weight", null: false
    t.bigint "inquiry_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_inquiry_items_on_deleted_at"
    t.index ["inquiry_id"], name: "index_inquiry_items_on_inquiry_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id", null: false
    t.bigint "conversation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "quote_items", force: :cascade do |t|
    t.string "name", null: false
    t.string "item_type", null: false
    t.float "amount", null: false
    t.string "routing"
    t.bigint "quote_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_quote_items_on_deleted_at"
    t.index ["quote_id"], name: "index_quote_items_on_quote_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.float "total_price"
    t.string "status", default: "Posted"
    t.bigint "inquiry_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_quotes_on_deleted_at"
    t.index ["inquiry_id"], name: "index_quotes_on_inquiry_id"
    t.index ["user_id"], name: "index_quotes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "website", default: "", null: false
    t.string "job_title", default: "", null: false
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "inquiries", "users"
  add_foreign_key "inquiry_items", "inquiries"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "quote_items", "quotes"
  add_foreign_key "quotes", "inquiries"
  add_foreign_key "quotes", "users"
end
