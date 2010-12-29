class DeclarativeAuthorization < ActiveRecord::Migration
   def self.up
     create_table "roles" do |t|
       t.column :title, :string
       t.references :user
     end
   end

   def self.down
     drop_table "roles"
   end
 end