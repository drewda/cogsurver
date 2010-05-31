class ViewerController < ApplicationController
  before_filter :authenticate_user!
  
  def main
    @direction_distance_estimates = []
    current_user.direction_distance_estimates.each do |dde|
      if not dde.distance_estimate_units.nil?
        @direction_distance_estimates << dde
      end
    end
  end
end