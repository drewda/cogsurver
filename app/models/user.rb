class User < ActiveRecord::Base
  has_many :landmarks
  has_many :landmark_visits
  has_many :direction_distance_estimates
  has_many :regions
  has_many :logs_entries
end
