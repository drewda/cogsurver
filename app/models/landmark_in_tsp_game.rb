class LandmarkInTspGame < ActiveRecord::Base
  belongs_to :landmark
  belongs_to :tsp_game
  has_many :tsp_stops, :order => 'tsp_stops.order ASC'
end