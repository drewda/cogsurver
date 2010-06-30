class LandmarkVisit < ActiveRecord::Base
  belongs_to :user
  belongs_to :landmark
  has_many :direction_distance_estimates

  def total_absolute_direction_error
    total_absolute_direction_error = 0
    direction_distance_estimates.each do |dde|
      total_absolute_direction_error += dde.absolute_direction_error
    end
    total_absolute_direction_error
  end

  def average_absolute_direction_error
    total_absolute_direction_error / direction_distance_estimates.length
  end

  def total_absolute_distance_error
    total_absolute_distance_error = 0
    direction_distance_estimates.each do |dde|
      total_absolute_distance_error += dde.distance_error.abs unless dde.distance_error.nil?
      # note that we're ignoring north pointing instances
    end
    total_absolute_distance_error
  end

  def average_absolute_distance_error
    total_absolute_distance_error / direction_distance_estimates.length
  end
end
