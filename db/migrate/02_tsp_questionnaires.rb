class TspQuestionnaires < ActiveRecord::Migration
  def self.up
    create_table :before_questionnaire do |t|
      t.integer :user_id
      t.string :sex
      t.integer :age
      t.integer :years_in_berk
      t.boolean :live_in_berk
      t.boolean :work_in_berk
      t.boolean :cal_student
      t.boolean :bcc_student
      t.string :other_demographic
      t.integer :familiarity_berk_high
      t.integer :familiarity_cvs
      t.integer :familiarity_triple_rock
      t.integer :familiarity_berk_rep
      t.integer :familiarity_au_coquelet
      t.integer :familiarity_jupiter
      t.integer :familiarity_starbucks
      t.string :carry_a_cell
      t.boolean :cell_voice
      t.boolean :cell_maps
      t.boolean :cell_web
      t.boolean :cell_text
      t.boolean :cell_email
      t.string :cell_other
      t.timestamps
    end
    create_table :sbsod_records do |t|
      t.integer :user_id
      t.integer :q1
      t.integer :q2
      t.integer :q3
      t.integer :q4
      t.integer :q5
      t.integer :q6
      t.integer :q7
      t.integer :q8
      t.integer :q9
      t.integer :q10
      t.integer :q11
      t.integer :q12
      t.integer :q13
      t.integer :q14
      t.integer :q15
      t.timestamps
    end
  end
  def self.down
    drop_table :before_questionnaire
    drop_table :sbsod_records
  end
end