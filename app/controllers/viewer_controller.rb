class ViewerController < ApplicationController
  before_filter :authenticate_user!
  
  def main
    @direction_distance_estimates = []
    current_user.direction_distance_estimates.each do |dde|
      #if not dde.distance_estimate_units.nil?
      if dde.target_landmark_id != 0
        @direction_distance_estimates << dde
      end
    end
    
    @landmarksGeoJson = "["
    current_user.landmarks.each do |landmark|
      @landmarksGeoJson << "{geometry: {coordinates: [#{landmark.longitude}, #{landmark.latitude}], type: 'Point'}, data: {name : \"#{landmark.name}\"}},"
    end
    @landmarksGeoJson << "]"
  end
end
