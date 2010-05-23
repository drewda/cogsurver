# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "direction_distance_estimates", :force => true do |t|
    t.integer  "user_id"
    t.integer  "landmark_visit_id"
    t.integer  "start_landmark_id"
    t.integer  "target_landmark_id"
    t.integer  "direction_estimate",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "distance_estimate",       :limit => 10, :precision => 10, :scale => 0
    t.string   "distance_estimate_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "landmark_visits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "landmark_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "landmarks", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "foursquare_venue_id"
    t.integer  "latitude",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "longitude",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "region_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_entries", :force => true do |t|
    t.integer  "user_id"
    t.string   "category"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "same_landmarks", :force => true do |t|
    t.integer  "master_landmark_id"
    t.integer  "slave_landmark_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_fixes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "latitude",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "longitude",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "altitude",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "speed",              :limit => 10, :precision => 10, :scale => 0
    t.integer  "accuracy",           :limit => 10, :precision => 10, :scale => 0
    t.string   "positioning_method"
    t.string   "travel_mode"
    t.datetime "datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "foursquare_user_id"
    t.string   "email_address"
    t.datetime "last_web_access"
    t.datetime "last_mobile_access"
    t.string   "last_mobile_client"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
