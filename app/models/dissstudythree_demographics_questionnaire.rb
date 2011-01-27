class DissstudythreeDemographicsQuestionnaire < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :presence => true
  validates :age, :presence => true, :numericality => true
  validates :sex, :presence => true, :inclusion => {:in => ["male", "female"]}
  validates :years_in_current_region, :presence => true, :numericality => true
  validates :primary_mode_of_transportation, :presence => true
  validates :phone_model, :presence => true
  validates :months_with_a_smartphone, :presence => true, :numericality => true
  validates :smartphone_skill_rating, :presence => true, :numericality => true
end