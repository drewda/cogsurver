class OrganizeUsersIntoStudies < ActiveRecord::Migration
  def self.up
    create_table :studies do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :studies_users, :id => false do |t|
      t.integer :study_id
      t.integer :user_id
    end
    add_index :studies_users, :study_id
    add_index :studies_users, :user_id
  end

  def self.down
    remove_index :studies_users, :user_id
    remove_index :studies_users, :study_id
    remove_column :users, :study_id
    drop_table :studies
  end
end