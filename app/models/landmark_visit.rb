class LandmarkVisit < ActiveRecord::Base
  belongs_to :user
  belongs_to :landmark
  has_many :direction_distance_estimates
end
