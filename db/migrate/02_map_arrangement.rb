class MapArrangement < ActiveRecord::Migration
  def self.up
    create_table :map_arrangements do |t|
      t.integer :user_id
      t.integer :pixel_width
      t.integer :pixel_height
      t.double :upper_left_latitude
      t.double :upper_left_longitude
      t.double :lower_right_latitude
      t.double :lower_right_longitude
      t.integer :seconds_taken
      t.timestamps
    end
    create_table :map_arrangement_pieces do |t|
      t.integer :map_arrangement_id
      t.integer :landmark_id
      t.integer :upper_left_pixel_x
      t.integer :upper_left_pixel_y
      t.integer :placement_order
      t.timestamps
    end
  end
  def self.down
    drop_table :map_arrangements
    drop_table :map_arrangement_pieces
  end
end

