class LandmarkVisit < ActiveRecord::Base
  belongs_to :user
  belongs_to :landmark
end
