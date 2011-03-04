class Landmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
  has_many :landmark_visits
  has_and_belongs_to_many :same_landmarks,
                          :class_name => "Landmark",
                          :join_table => "same_landmarks",
                          :foreign_key => "master_landmark_id",
                          :association_foreign_key => "slave_landmark_id"
  has_many :direction_distance_estimates_from, 
           :class_name => "DirectionDistanceEstimate", 
           :foreign_key =>"start_landmark_id"
  has_many :direction_distance_estimates_to, 
           :class_name => "DirectionDistanceEstimate", 
           :foreign_key =>"target_landmark_id"

  def num_visits
    self.landmark_visits.length
  end

  def average_absolute_direction_error_to
    total_absolute_direction_error = 0
    direction_distance_estimates_to.each do |dde|
      total_absolute_direction_error += dde.absolute_direction_error
    end
    total_absolute_direction_error / direction_distance_estimates_to.length unless direction_distance_estimates_to.length == 0
  end

  def average_absolute_distance_error_to
    total_absolute_distance_error = 0
    n = 0
    direction_distance_estimates_to.each do |dde|
      total_absolute_distance_error += dde.distance_error.abs unless dde.distance_estimate == 0
      # note that we're ignoring north pointing instances
      n += 1
    end
    total_absolute_distance_error / n unless n == 0
  end

  def average_absolute_direction_error_from
    total_absolute_direction_error = 0
    direction_distance_estimates_from.each do |dde|
      total_absolute_direction_error += dde.absolute_direction_error
    end
    total_absolute_direction_error / direction_distance_estimates_to.length unless direction_distance_estimates_to.length == 0
  end

  def average_absolute_distance_error_from
    total_absolute_distance_error = 0
    n = 0
    direction_distance_estimates_from.each do |dde|
      total_absolute_distance_error += dde.distance_error.abs unless dde.distance_estimate == 0
      # note that we're ignoring north pointing instances
      n += 1
    end
    total_absolute_distance_error / n unless n == 0
  end
  
  def before_visit_average_absolute_direction_error_to
    total_absolute_direction_error = 0
    estimates = []
    if not landmark_visits.first.nil?
      estimates = direction_distance_estimates_to.find(:all, :conditions => ["created_at < ?", landmark_visits.first.created_at])
    end
    estimates.each do |dde|
      total_absolute_direction_error += dde.absolute_direction_error
    end
    total_absolute_direction_error / estimates.length unless estimates.length == 0
  end

  def before_visit_average_absolute_distance_error_to
    total_absolute_distance_error = 0
    estimates = []
    if not landmark_visits.first.nil?
      estimates = direction_distance_estimates_to.find(:all, :conditions => ["created_at < ?", landmark_visits.first.created_at])
    end
    n = 0
    estimates.each do |dde|
      total_absolute_distance_error += dde.distance_error.abs unless dde.distance_estimate == 0
      # note that we're ignoring north pointing instances
      n += 1
    end
    total_absolute_distance_error / n unless n == 0
  end
  
  def after_visit_average_absolute_direction_error_to
    total_absolute_direction_error = 0
    estimates = []
    if not landmark_visits.first.nil?
      estimates = direction_distance_estimates_to.find(:all, :conditions => ["created_at > ?", landmark_visits.first.created_at])
    end
    estimates.each do |dde|
      total_absolute_direction_error += dde.absolute_direction_error
    end
    total_absolute_direction_error / estimates.length unless estimates.length == 0
  end

  def after_visit_average_absolute_distance_error_to
    total_absolute_distance_error = 0
    estimates = []
    if not landmark_visits.first.nil?
      estimates = direction_distance_estimates_to.find(:all, :conditions => ["created_at > ?", landmark_visits.first.created_at])
    end
    n = 0
    estimates.each do |dde|
      total_absolute_distance_error += dde.distance_error.abs unless dde.distance_estimate == 0
      # note that we're ignoring north pointing instances
      n += 1
    end
    total_absolute_distance_error / n unless n == 0
  end
  
  def estimated_location
    # based on code from http://www.geomidpoint.com/
    
    if self.direction_distance_estimates_to.length > 0
      x = 0
      y = 0
      z = 0
      self.direction_distance_estimates_to.each do |dde|
        x += Math.cos(dde.end_point[:latitude] * Math::PI / 180) * Math.cos(dde.end_point[:longitude] * Math::PI / 180)
        y += Math.cos(dde.end_point[:latitude] * Math::PI / 180) * Math.sin(dde.end_point[:longitude] * Math::PI / 180)
        z += Math.sin(dde.end_point[:latitude] * Math::PI / 180)
      end
      x = x / self.direction_distance_estimates_to.length
      y = y / self.direction_distance_estimates_to.length
      z = z / self.direction_distance_estimates_to.length

      longitude = Math.atan2(y, x)
      hyp = Math.sqrt(x * x + y * y)
      latitude = Math.atan2(z, hyp)
    
      longitude = longitude * 180 / Math::PI
      latitude = latitude * 180 / Math::PI

      {:longitude => longitude, :latitude => latitude}
    else
      {:longitude => self.longitude, :latitude => self.latitude}
    end
  end
end
