class User < ActiveRecord::Base
  has_many :travel_fixes
  has_many :landmarks
  has_many :landmark_visits
  has_many :direction_distance_estimates
  has_many :regions
  has_many :log_entries
  
  devise :database_authenticatable, :recoverable,
         :rememberable, :registerable, :trackable, :timeoutable, :validatable
  attr_accessible :email, :password, :password_confirmation
  
  has_many :roles
  def role_symbols
    (roles || []).map {|r| r.title.to_sym}
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
