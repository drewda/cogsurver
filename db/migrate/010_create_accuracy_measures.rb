class CreateAccuracyMeasures < ActiveRecord::Migration
  def self.up
    create_table :gps_accuracy_measures do |t|
      t.integer :user_id
      t.decimal :measured_latitude, :precision => 15, :scale => 10
      t.decimal :measured_longitude, :precision => 15, :scale => 10
      t.decimal :measured_altitude, :precision => 8, :scale => 2
      t.decimal :measured_speed, :precision => 5, :scale => 2
      t.decimal :measured_accuracy, :precision => 5, :scale => 2
      t.decimal :specified_latitude, :precision => 15, :scale => 10
      t.decimal :specified_longitude, :precision => 15, :scale => 10
      t.string :specified_against
      t.string :device
      t.timestamps
    end
    
    create_table :compass_accuracy_measures do |t|
      t.integer :user_id
      t.decimal :measured_direction_estimate, :precision => 5, :scale => 2
      t.decimal :specified_direction_estimate, :precision => 5, :scale => 2
      t.string :specified_against
      t.string :device
      t.timestamps
    end
  end

  def self.down
    drop_table :compass_accuracy_measures
    drop_table :gps_accuracy_measures
  end
end