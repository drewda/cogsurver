class DissStudyThreeAdditions < ActiveRecord::Migration
  def self.up
    add_column :users, :participating_in_study, :string
    add_column :users, :gave_consent, :datetime
    add_column :users, :column_name, :string
    
    add_column :landmarks, :familiarity_rating, :integer
    
    create_table :dissstudythree_demographics_questionnaires do |t|
      t.integer :user_id
      t.integer :age
      t.string :sex
      t.integer :years_in_current_region
      t.string :primary_mode_of_transportation
      t.string :phone_model
      t.integer :months_with_a_smartphone
      t.integer :smartphone_skill_rating
      t.timestamps
    end
    
    create_table :dissstudythree_final_questionnaires do |t|
      t.integer :user_id
      t.text :attention_to_surroundings
      t.text :affect_travel
      t.text :revealing
      t.text :features
      t.text :comments_questions
      t.timestamps
    end
  end

  def self.down
    remove_column :landmarks, :familiarity_rating
    drop_table :dissstudythree_final_questionnaires
    drop_table :dissstudythree_demographics_questionnaires
    remove_column :users, :column_name
    remove_column :users, :gave_consent
    remove_column :users, :participating_in_study
  end
end