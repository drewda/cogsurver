class Landmark < ActiveRecord::Base
  belongs_to :user
  has_many :direction_distance_estimates
  belongs_to :region
  has_many :landmark_visits
  has_and_belongs_to_many :same_landmarks,
                          :class_name => "Landmark",
                          :join_table => "same_landmarks",
                          :foreign_key => "master_landmark_id",
                          :association_foreign_key => "slave_landmark_id"
end
