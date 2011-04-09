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

ActiveRecord::Schema.define(:version => 12) do

  create_table "before_questionnaires", :force => true do |t|
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

  create_table "compass_accuracy_measures", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "measured_direction_estimate",  :precision => 5, :scale => 2
    t.decimal  "specified_direction_estimate", :precision => 5, :scale => 2
    t.string   "specified_against"
    t.string   "device"
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
    t.string   "kind"
  end

  create_table "dissstudythree_demographics_questionnaires", :force => true do |t|
    t.integer  "user_id"
    t.integer  "age"
    t.string   "sex"
    t.integer  "years_in_current_region"
    t.string   "primary_mode_of_transportation"
    t.string   "phone_model"
    t.integer  "months_with_a_smartphone"
    t.integer  "smartphone_skill_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dissstudythree_final_questionnaires", :force => true do |t|
    t.integer  "user_id"
    t.text     "lbs_use"
    t.text     "attention_to_surroundings"
    t.text     "affect_travel"
    t.text     "revealing"
    t.text     "features"
    t.text     "comments_questions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gps_accuracy_measures", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "measured_latitude",   :precision => 15, :scale => 10
    t.decimal  "measured_longitude",  :precision => 15, :scale => 10
    t.decimal  "measured_altitude",   :precision => 8,  :scale => 2
    t.decimal  "measured_speed",      :precision => 5,  :scale => 2
    t.decimal  "measured_accuracy",   :precision => 5,  :scale => 2
    t.decimal  "specified_latitude",  :precision => 15, :scale => 10
    t.decimal  "specified_longitude", :precision => 15, :scale => 10
    t.string   "specified_against"
    t.string   "device"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "landmark_in_tsp_games", :force => true do |t|
    t.integer  "landmark_id"
    t.integer  "tsp_game_id"
    t.boolean  "first_and_last"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "landmark_in_tsp_games", ["landmark_id"], :name => "index_landmark_in_tsp_games_on_landmark_id"
  add_index "landmark_in_tsp_games", ["tsp_game_id"], :name => "index_landmark_in_tsp_games_on_tsp_game_id"

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
    t.integer  "familiarity_rating"
    t.integer  "fix_accuracy"
    t.boolean  "manually_adjusted"
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

  create_table "roles", :force => true do |t|
    t.string  "title"
    t.integer "user_id"
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

  create_table "studies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studies_users", :id => false, :force => true do |t|
    t.integer "study_id"
    t.integer "user_id"
  end

  add_index "studies_users", ["study_id"], :name => "index_studies_users_on_study_id"
  add_index "studies_users", ["user_id"], :name => "index_studies_users_on_user_id"

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

  create_table "tsp_games", :force => true do |t|
    t.integer  "user_id"
    t.integer  "first_travel_fix_id"
    t.integer  "last_travel_fix_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tsp_games", ["first_travel_fix_id"], :name => "index_tsp_games_on_first_travel_fix_id"
  add_index "tsp_games", ["last_travel_fix_id"], :name => "index_tsp_games_on_last_travel_fix_id"
  add_index "tsp_games", ["user_id"], :name => "index_tsp_games_on_user_id"

  create_table "tsp_stops", :force => true do |t|
    t.integer  "tsp_game_id"
    t.integer  "order"
    t.integer  "landmark_visit_id"
    t.integer  "travel_fix_id"
    t.integer  "landmark_in_tsp_game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tsp_stops", ["landmark_visit_id"], :name => "index_tsp_stops_on_landmark_visit_id"
  add_index "tsp_stops", ["travel_fix_id"], :name => "index_tsp_stops_on_travel_fix_id"
  add_index "tsp_stops", ["tsp_game_id"], :name => "index_tsp_stops_on_tsp_game_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "foursquare_user_id"
    t.datetime "last_web_access"
    t.datetime "last_mobile_access"
    t.string   "last_mobile_client"
    t.string   "email",                                                         :default => "", :null => false
    t.string   "encrypted_password",                             :limit => 128, :default => "", :null => false
    t.string   "password_salt",                                                 :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                 :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "travel_log_service_enabled"
    t.integer  "travel_log_service_interval"
    t.integer  "last_region_id"
    t.string   "participating_in_study"
    t.datetime "gave_consent"
    t.boolean  "dissstudythree_landmark_questionnaire_complete"
    t.boolean  "hide_explorer_tutorial"
  end

end
