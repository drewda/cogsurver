class AddLandmarkAccuracyAndAdjustment < ActiveRecord::Migration
  def self.up
    add_column :landmarks, :fix_accuracy, :integer
    add_column :landmarks, :manually_adjusted, :boolean
  end

  def self.down
    remove_column :landmarks, :manually_adjusted
    remove_column :landmarks, :fix_accuracy
  end
end