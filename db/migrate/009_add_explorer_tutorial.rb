class AddExplorerTutorial < ActiveRecord::Migration
  def self.up
    add_column :users, :hide_explorer_tutorial, :boolean
  end

  def self.down
    remove_column :users, :hide_explorer_tutorial
  end
end