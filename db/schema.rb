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

ActiveRecord::Schema.define(:version => 2) do

  create_table "before_questionnaire", :force => true do |t|
    t.integer  "user_id"
    t.string   "sex"
    t.integer  "age"
    t.integer  "years_in_berk"
    t.boolean  "live_in_berk"
    t.boolean  "work_in_berk"
    t.boolean  "cal_student"
    t.boolean  "bcc_student"
    t.string   "other_demographic"
    t.integer  "familiarity_berk_high"
    t.integer  "familiarity_cvs"
    t.integer  "familiarity_triple_rock"
    t.integer  "familiarity_berk_rep"
    t.integer  "familiarity_au_coquelet"
    t.integer  "familiarity_jupiter"
    t.integer  "familiarity_starbucks"
    t.string   "carry_a_cell"
    t.boolean  "cell_voice"
    t.boolean  "cell_maps"
    t.boolean  "cell_web"
    t.boolean  "cell_text"
    t.boolean  "cell_email"
    t.string   "cell_other"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "direction_distance_estimates", :force => true do |t|
    t.integer  "user_id"
    t.integer  "landmark_visit_id"
    t.integer  "start_landmark_id"
    t.integer  "target_landmark_id"
    t.decimal  "direction_estimate",      :precision => 5,  :scale => 2
    t.decimal  "distance_estimate",       :precision => 15, :scale => 2
    t.string   "distance_estimate_units"
    t.datetime "datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "landmark_visits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "landmark_id"
    t.datetime "datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "landmarks", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "foursquare_venue_id"
    t.decimal  "latitude",            :precision => 15, :scale => 10
    t.decimal  "longitude",           :precision => 15, :scale => 10
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

  create_table "same_landmarks", :id => false, :force => true do |t|
    t.integer  "master_landmark_id"
    t.integer  "slave_landmark_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sbsod_records", :force => true do |t|
    t.integer  "user_id"
    t.integer  "q1"
    t.integer  "q2"
    t.integer  "q3"
    t.integer  "q4"
    t.integer  "q5"
    t.integer  "q6"
    t.integer  "q7"
    t.integer  "q8"
    t.integer  "q9"
    t.integer  "q10"
    t.integer  "q11"
    t.integer  "q12"
    t.integer  "q13"
    t.integer  "q14"
    t.integer  "q15"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_fixes", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "latitude",           :precision => 15, :scale => 10
    t.decimal  "longitude",          :precision => 15, :scale => 10
    t.decimal  "altitude",           :precision => 8,  :scale => 2
    t.decimal  "speed",              :precision => 5,  :scale => 2
    t.decimal  "accuracy",           :precision => 5,  :scale => 2
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
    t.datetime "last_web_access"
    t.datetime "last_mobile_access"
    t.string   "last_mobile_client"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
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
