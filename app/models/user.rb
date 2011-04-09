class User < ActiveRecord::Base
  has_many :travel_fixes
  has_many :landmarks
  has_many :landmark_visits
  has_many :direction_distance_estimates
  has_many :regions
  has_many :log_entries
  
  has_and_belongs_to_many :studies
  
  # DissStudyOne TSP
  has_one :before_questionnaire
  has_one :sbsod_record
  # added for additional analysis
  has_many :tsp_games
  
  # DissStudyThree Images
  has_one :dissstudythree_demographics_questionnaire
  has_one :dissstudythree_final_questionnaire
  
  has_many :gps_accuracy_measures
  has_many :compass_accuracy_measures
  
  devise :database_authenticatable, :recoverable,
         :rememberable, :registerable, :trackable, :timeoutable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :travel_log_service_enabled, :travel_log_service_interval,
                  :hide_explorer_tutorial, :first_name, :last_name
  
  has_many :roles
  def role_symbols
    (roles || []).map {|r| r.title.to_sym}
  end

  def title
    return self.full_name
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  attr_accessor :current_user
  def is_current_user
    return self == current_user
  end
  
  def total_absolute_direction_error
    total_absolute_direction_error = 0
    direction_distance_estimates.each do |dde|
      total_absolute_direction_error += dde.absolute_direction_error
    end
    total_absolute_direction_error
  end

  def average_absolute_direction_error
    total_absolute_direction_error / direction_distance_estimates.length unless direction_distance_estimates.length == 0
  end
  
  def north_direction_estimates
    direction_distance_estimates.find(:all, :conditions => "target_landmark_id = 'null'")
  end
  
  def average_north_direction_error
    total_north_direction_error = 0
    north_direction_estimates.each do |dde|
      if dde.direction_estimate > 180
        total_north_direction_error += 360 - dde.direction_estimate
      else
        total_north_direction_error += dde.direction_estimate
      end
    end
    total_north_direction_error / north_direction_estimates.length unless north_direction_estimates.length == 0
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
    total_absolute_distance_error / direction_distance_estimates.length unless direction_distance_estimates.length == 0
  end
end
