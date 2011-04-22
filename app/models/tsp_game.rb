class TspGame < ActiveRecord::Base
  belongs_to :user
  has_many :tsp_stops, :order => 'tsp_stops.order ASC'
  has_many :landmark_in_tsp_games
  has_many :landmarks, :through => :landmark_in_tsp_games
  belongs_to :first_travel_fix, :class_name => 'TravelFix'
  belongs_to :last_travel_fix, :class_name => 'TravelFix'
  
  def gps_distance_traveled(units='miles')
    self.first_travel_fix.distance_covered_between(self.last_travel_fix, units)
  end
end