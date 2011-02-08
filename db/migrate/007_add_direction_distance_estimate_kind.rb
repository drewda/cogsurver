class AddDirectionDistanceEstimateKind < ActiveRecord::Migration
  def self.up
    add_column :direction_distance_estimates, :kind, :string
  end

  def self.down
    remove_column :direction_distance_estimates, :kind
  end
end