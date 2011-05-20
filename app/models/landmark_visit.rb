class LandmarkVisit < ActiveRecord::Base
  belongs_to :user
  belongs_to :landmark
  has_many :direction_distance_estimates

  def average_absolute_direction_error
    total_absolute_direction_error = 0
    direction_distance_estimates.each do |dde|
      total_absolute_direction_error += dde.absolute_direction_error
    end
    total_absolute_direction_error / direction_distance_estimates.length unless direction_distance_estimates.length == 0
  end

  def average_absolute_distance_error
    total_absolute_distance_error = 0
    n = 0
    direction_distance_estimates.each do |dde|
      if dde.distance_estimate > 0 # note that we're ignoring north pointing instances
        total_absolute_distance_error += dde.distance_error.abs unless dde.distance_estimate == 0
        n += 1
      end
    end
    total_absolute_distance_error / n unless n == 0
  end
  
  def distance_correlation
    @r = RSRuby.instance
    distance_estimates = []
    actual_distances = []
    self.direction_distance_estimates.where(:kind => 'landmarkToLandmark').each do |dde|
      if dde.distance_estimate > 0
        distance_estimates << dde.distance_estimate.to_f
        actual_distances << dde.actual_distance.to_f
      end
    end
    if distance_estimates.length > 0 and actual_distances.length > 0 and distance_estimates.length == actual_distances.length
      @r.cor(distance_estimates, actual_distances)
    end
  end
  
  def north_direction_estimate
    direction_distance_estimates.where(:kind => 'landmarkToNorth').first
  end
  
  def cog_distance_rank_from_last_landmark
    landmarks_already_visited = []
    user.landmark_visits.find(:all, :conditions => ["created_at < ?", created_at]).each do |lv|
      landmarks_already_visited << lv.landmark
    end
    if landmarks_already_visited.length == 0
      return 0
    else
      landmarks_left_to_visit = user.landmarks - landmarks_already_visited
      landmarks_left_to_visit_with_cog_distances = []
      landmarks_left_to_visit.each do |l|
        dde = DirectionDistanceEstimate.find(:first, :conditions => ["start_landmark_id = ? and target_landmark_id = ?", landmarks_already_visited.last.id, l.id])
        if dde.nil?
          cog_distance = 1.0/0 # Infinity
        else
          cog_distance = dde.distance_estimate
        end
        landmarks_left_to_visit_with_cog_distances << {:landmark => l, :cog_distance => cog_distance}
      end
      landmarks_left_to_visit_with_cog_distances = landmarks_left_to_visit_with_cog_distances.sort_by {|l| l[:cog_distance]}
      rank = 0
      landmarks_left_to_visit_with_cog_distances.each do |l|
        rank += 1
        break if l[:landmark] == landmark
      end
      return rank
    end
  end
  
  def distance_rank_from_last_landmark
    landmarks_already_visited = []
    user.landmark_visits.find(:all, :conditions => ["created_at < ?", created_at]).each do |lv|
      landmarks_already_visited << lv.landmark
    end
    if landmarks_already_visited.length == 0
      return 0
    else
      landmarks_left_to_visit = user.landmarks - landmarks_already_visited
      landmarks_left_to_visit_with_distances = []
      landmarks_left_to_visit.each do |l|
        start = Geokit::LatLng.new(lat=landmarks_already_visited.last.latitude,lng=landmarks_already_visited.last.longitude)
        target = Geokit::LatLng.new(lat=l.latitude,lng=l.longitude)
        distance = start.distance_to(target)
        landmarks_left_to_visit_with_distances << {:landmark => l, :distance => distance}
      end
      landmarks_left_to_visit_with_distances = landmarks_left_to_visit_with_distances.sort_by {|l| l[:distance]}
      rank = 0
      landmarks_left_to_visit_with_distances.each do |l|
        rank += 1
        break if l[:landmark] == landmark
      end
      return rank
    end
  end
  
  def familiarity_rank_from_last_landmark
    return nil
  end
end
