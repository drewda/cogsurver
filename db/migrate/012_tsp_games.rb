class TspGames < ActiveRecord::Migration
  def self.up
    create_table :tsp_games do |t|
      t.integer :user_id
      t.integer :first_travel_fix_id
      t.integer :last_travel_fix_id
      t.timestamps
    end
    add_index :tsp_games, :user_id
    add_index :tsp_games, :first_travel_fix_id
    add_index :tsp_games, :last_travel_fix_id
    
    create_table :tsp_stops, :force => true do |t|
      t.integer :tsp_game_id
      t.integer :order
      t.integer :landmark_visit_id
      t.integer :travel_fix_id
      t.integer :landmark_in_tsp_game_id
      t.timestamps
    end
    add_index :tsp_stops, :tsp_game_id
    add_index :tsp_stops, :landmark_visit_id
    add_index :tsp_stops, :travel_fix_id
    
    create_table :landmark_in_tsp_games, :force => true do |t|
      t.integer :landmark_id
      t.integer :tsp_game_id
      t.boolean :first_and_last
      t.timestamps
    end
    add_index :landmark_in_tsp_games, :landmark_id
    add_index :landmark_in_tsp_games, :tsp_game_id
  end

  def self.down
    remove_index :landmark_in_tsp_games, :tsp_game_id
    remove_index :landmark_in_tsp_games, :landmark_id
    remove_index :tsp_stops, :travel_fix_id
    remove_index :tsp_stops, :landmark_visit_id
    remove_index :tsp_stops, :tsp_game_id
    remove_index :tsp_games, :last_travel_fix_id
    remove_index :tsp_games, :first_travel_fix_id
    remove_index :tsp_games, :user_id
    drop_table :landmark_in_tsp_games
    drop_table :tsp_stops
    drop_table :tsp_games
  end
end