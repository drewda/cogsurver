class AdditionalUserPreferences < ActiveRecord::Migration
  def self.up
    add_column :users, :travel_log_service_enabled, :boolean
    add_column :users, :travel_log_service_interval, :integer # milliseconds
    add_column :users, :last_region_id, :integer
  end

  def self.down
    remove_column :users, :travel_log_service_enabled
    remove_column :users, :travel_log_service_interval
    remove_column :users, :last_region_id
  end
end
