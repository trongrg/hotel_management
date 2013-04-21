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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130223114833) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "addresses", :force => true do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], :name => "index_addresses_on_addressable_type_and_addressable_id", :unique => true

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "check_ins", :force => true do |t|
    t.string   "status"
    t.integer  "guest_id"
    t.integer  "hotel_id"
    t.integer  "adults"
    t.integer  "children"
    t.integer  "special_request"
    t.integer  "prepaid_cents"
    t.string   "currency"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "check_ins", ["guest_id"], :name => "index_check_ins_on_guest_id"
  add_index "check_ins", ["hotel_id"], :name => "index_check_ins_on_hotel_id"

  create_table "check_ins_rooms", :id => false, :force => true do |t|
    t.integer "check_in_id"
    t.integer "room_id"
  end

  add_index "check_ins_rooms", ["check_in_id", "room_id"], :name => "index_check_ins_rooms_on_check_in_id_and_room_id"
  add_index "check_ins_rooms", ["room_id", "check_in_id"], :name => "index_check_ins_rooms_on_room_id_and_check_in_id"

  create_table "guests", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "gender"
    t.string   "passport"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hotels", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "slug"
  end

  add_index "hotels", ["slug"], :name => "index_hotels_on_slug"
  add_index "hotels", ["user_id"], :name => "index_hotels_on_user_id"

  create_table "hotels_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "hotel_id"
  end

  add_index "hotels_users", ["user_id", "hotel_id"], :name => "index_hotels_users_on_user_id_and_hotel_id"

  create_table "locations", :force => true do |t|
    t.decimal  "latitude",       :precision => 20, :scale => 16
    t.decimal  "longitude",      :precision => 20, :scale => 16
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "hotel_id"
    t.integer  "guest_id"
    t.string   "status"
    t.string   "prepaid_cents"
    t.string   "currency"
    t.date     "check_in_date"
    t.date     "check_out_date"
    t.integer  "adults"
    t.integer  "children"
    t.text     "special_request"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "reservations", ["guest_id"], :name => "index_reservations_on_guest_id"
  add_index "reservations", ["hotel_id"], :name => "index_reservations_on_hotel_id"

  create_table "reservations_rooms", :force => true do |t|
    t.integer "reservation_id"
    t.integer "room_id"
  end

  add_index "reservations_rooms", ["reservation_id"], :name => "index_reservations_rooms_on_reservation_id"
  add_index "reservations_rooms", ["room_id"], :name => "index_reservations_rooms_on_room_id"

  create_table "room_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price_cents"
    t.string   "currency"
    t.integer  "hotel_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  add_index "room_types", ["slug"], :name => "index_room_types_on_slug"

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.integer  "room_type_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "available",    :default => true, :null => false
  end

  add_index "rooms", ["room_type_id"], :name => "index_rooms_on_room_type_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "phone"
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
