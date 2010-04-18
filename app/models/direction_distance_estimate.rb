class DirectionDistanceEstimate < ActiveRecord::Base
  belongs_to :user
  belongs_to :landmark_visit
  belongs to :start_landmark, :class_name => "Landmark"
  belongs_to :target_landmark, :class_name => "Landmark"
end
