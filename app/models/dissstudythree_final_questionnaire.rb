class DissstudythreeFinalQuestionnaire < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :presence => true
  validates :lbs_use, :presence => true
  validates :attention_to_surroundings, :presence => true
  validates :affect_travel, :presence => true
  validates :revealing, :presence => true
  validates :features, :presence => true
end