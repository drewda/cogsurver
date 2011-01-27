class DirectionDistanceEstimate < ActiveRecord::Base
  belongs_to :user
  belongs_to :landmark_visit
  belongs_to :start_landmark, :class_name => "Landmark"
  belongs_to :target_landmark, :class_name => "Landmark"
  
  def actual_distance
    return nil if !target_landmark
        
    start = Geokit::LatLng.new(lat=start_landmark.latitude,lng=start_landmark.longitude)
    target = Geokit::LatLng.new(lat=target_landmark.latitude,lng=target_landmark.longitude)
    if (distance_estimate_units == 'miles')
      start.distance_to(target, :units => :miles)
    elsif (distance_estimate_units == 'feet')
      start.distance_to(target, :units => :miles) * 5280
    elsif (distance_estimate_units == 'kilometers')
      start.distance_to(target, :units => :kms)
    elsif (distance_estimate_units == 'meters')
      start.distance_to(target, :units => :kms) * 1000 
    end
  end
  
  def distance_error
    # north pointing
    if target_landmark_id == 0
      nil
    else
      distance_estimate - actual_distance
    end
  end
  
  def actual_direction
    return 0 if !target_landmark # north pointing
    
    start = Geokit::LatLng.new(lat=start_landmark.latitude,lng=start_landmark.longitude)
    target = Geokit::LatLng.new(lat=target_landmark.latitude,lng=target_landmark.longitude)
    
    start.heading_to(target)
  end
  
  def absolute_direction_error
    # north pointing --- actual_direction is 0
    if target_landmark_id == 0 
      if direction_estimate > 180
        absolute_direction_error = (360 - direction_estimate).abs
      else
        direction_estimate
      end
    # normal landmark target
    else  
      absolute_direction_error = (direction_estimate - actual_direction).modulo(360) 
      if absolute_direction_error > 180
        absolute_direction_error = 360 - absolute_direction_error
      else
        absolute_direction_error
      end
    end
  end
  
  def end_point
    return nil if !target_landmark
    
    start = Geokit::LatLng.new(lat=start_landmark.latitude,lng=start_landmark.longitude)
    target = Geokit::LatLng.new(lat=target_landmark.latitude,lng=target_landmark.longitude)
    
    if (distance_estimate_units == 'miles')
      distance = distance_estimate
    elsif (distance_estimate_units == 'feet')
      distance = distance_estimate / 5280
    elsif (distance_estimate_units == 'kilometers')
      distance = distance_estimate * 0.621371192
    elsif (distance_estimate_units == 'meters')
      distance = distance_estimate * 0.621371192 / 1000 
    end

    endpoint = start.endpoint(direction_estimate, distance)
    {:longitude => endpoint.lng, :latitude => endpoint.lat}
  end
end
