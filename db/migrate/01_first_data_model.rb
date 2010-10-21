class FirstDataModel < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :foursquare_user_id
      t.datetime :last_web_access
      t.datetime :last_mobile_access
      t.string :last_mobile_client
      t.database_authenticatable
      t.recoverable
      t.rememberable
      t.trackable
      t.timestamps
    end
    create_table :travel_fixes do |t|
      t.integer :user_id
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.decimal :altitude, :precision => 8, :scale => 2
      t.decimal :speed, :precision => 5, :scale => 2
      t.decimal :accuracy, :precision => 5, :scale => 2
      t.string :positioning_method
      t.string :travel_mode
      t.datetime :datetime
      t.timestamps
    end
    create_table :landmarks do |t|
      t.string :name
      t.integer :user_id
      t.string :foursquare_venue_id
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.integer :region_id
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.text :description
      t.timestamps
    end
    create_table :same_landmarks, :id => false do |t|
      t.integer :master_landmark_id
      t.integer :slave_landmark_id
      t.timestamps
    end
    create_table :landmark_visits do |t|
      t.integer :user_id
      t.integer :landmark_id
      t.datetime :datetime
      t.timestamps
    end
    create_table :direction_distance_estimates do |t|
      t.integer :user_id
      t.integer :landmark_visit_id
      t.integer :start_landmark_id
      t.integer :target_landmark_id
      t.decimal :direction_estimate, :precision => 5, :scale => 2
      t.decimal :distance_estimate, :precision => 15, :scale => 2
      t.string :distance_estimate_units
      t.datetime :datetime
      t.timestamps
    end
    create_table :regions do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
    create_table :log_entries do |t|
      t.integer :user_id
      t.string :category
      t.string :note
      t.timestamps
    end
  end
  
  def self.down
    drop_table :users
    drop_table :landmarks
    drop_table :same_landmarks
    drop_table :landmark_visits
    drop_table :direction_distance_estimates
    drop_table :regions
    drop_table :log_entries
  end
end