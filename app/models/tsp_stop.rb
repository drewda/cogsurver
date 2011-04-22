class TspStop < ActiveRecord::Base
  belongs_to :tsp_game
  belongs_to :landmark_visit
  belongs_to :travel_fix
  belongs_to :landmark_in_tsp_game
  has_one :landmark, :through => :landmark_in_tsp_game
  
  ###
    # STOPS
    ###
  def previous_stop
    previous = tsp_game.tsp_stops.where(:order => self.order - 1)
    if previous.length == 0
      return nil
    else
      return previous.first
    end
  end
  
  def next_stop
    previous = tsp_game.tsp_stops.where(:order => self.order + 1)
    if previous.length == 0
      return nil
    else
      return previous.first
    end
  end
  
  ###
    # GPS DISTANCE
    ###
  def gps_distance_from_previous_stop(units='miles')
    if self.previous_stop and self.travel_fix and self.previous_stop.travel_fix
      self.travel_fix.distance_covered_between(self.previous_stop.travel_fix, units)
    else
      nil
    end
  end
  
  def gps_distance_from_previous_stop_rank

  end
  
  def gps_distance_to_next_stop(units='miles')
    if self.next_stop and self.travel_fix and self.next_stop.travel_fix
      self.travel_fix.distance_covered_between(self.next_stop.travel_fix, units)
    else
      nil
    end
  end
  
  def gps_distance_to_next_stop_rank
    nil
  end
  
  ###
    # GOOGLE (WALKING) ROUTE DISTANCE
    ###
  def google_route_distance_from_previous_stop(units='miles')
    if self.previous_stop
      self.previous_stop.landmark.google_walking_route_distance_to_landmark(self.landmark)
      # r = HTTParty.get("http://maps.googleapis.com/maps/api/directions/json?origin=#{self.previous_stop.landmark.latitude},#{self.previous_stop.landmark.longitude}" +
      #                  "&destination=#{self.landmark.latitude},#{self.landmark.longitude}" +
      #                  "&mode=walking&sensor=false")
      # j = Crack::JSON.parse(r.body)
      #     
      # total_distance_in_meters = 0
      # j['routes'][0]['legs'][0]['steps'].each do |step|
      #   total_distance_in_meters += step['distance']['value']
      # end
      #     
      # if (units == 'miles')
      #   total_distance_in_meters * 0.000621
      # elsif (units == 'feet')
      #   total_distance_in_meters * 3.28083
      # elsif (units == 'kilometers')
      #   total_distance_in_meters / 1000
      # elsif (units == 'meters')
      #   total_distance_in_meters
      # end
    else
      nil
    end
  end
  
  def google_route_distance_from_previous_stop_rank
    if self.landmarks_already_visited.length == 0
      return nil
    else
      landmarks_left_to_visit_with_distances = []
      self.landmarks_left_to_visit.each do |l|
        distance = self.landmarks_already_visited.last.google_walking_route_distance_to_landmark(l)
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
  
  def google_route_distance_to_next_stop(units='miles')
    if self.next_stop
      self.landmark.google_walking_route_distance_to_landmark(self.next_stop.landmark)
      # r = HTTParty.get("http://maps.googleapis.com/maps/api/directions/json?origin=#{self.landmark.latitude},#{self.landmark.longitude}" +
      #                  "&destination=#{self.next_stop.landmark.latitude},#{self.next_stop.landmark.longitude}" +
      #                  "&mode=walking&sensor=false")
      # j = Crack::JSON.parse(r.body)
      #     
      # total_distance_in_meters = 0
      # j['routes'][0]['legs'][0]['steps'].each do |step|
      #   total_distance_in_meters += step['distance']['value']
      # end
      #     
      # if units == 'miles'
      #   total_distance_in_meters * 0.000621371192
      # elsif units == 'feet'
      #   total_distance_in_meters * 3.28083
      # elsif units == 'kilometers'
      #   total_distance_in_meters / 1000
      # elsif units == 'meters'
      #   total_distance_in_meters
      # end
    else
      nil
    end
  end
  
  ###
    # STRAIGHTLINE DISTANCE
    ###
  def straightline_distance_from_previous_stop(units='miles')
    if self.previous_stop
      self.previous_stop.landmark.straightline_distance_to_landmark(self.landmark)
      # start = Geokit::LatLng.new(lat=self.previous_stop.landmark.latitude,lng=self.previous_stop.landmark.longitude)
      # target = Geokit::LatLng.new(lat=self.landmark.latitude,lng=self.landmark.longitude)
      # if units == 'miles'
      #   start.distance_to(target, :units => :miles)
      # elsif units == 'feet'
      #   start.distance_to(target, :units => :miles) * 5280
      # elsif units == 'kilometers'
      #   start.distance_to(target, :units => :kms)
      # elsif units == 'meters'
      #   start.distance_to(target, :units => :kms) * 1000 
      # end
    else
      nil
    end
  end
  
  def straightline_distance_from_previous_stop_rank  
    if self.landmarks_already_visited.length == 0
      return nil
    else
      landmarks_left_to_visit_with_distances = []
      self.landmarks_left_to_visit.each do |l|
        distance = self.landmarks_already_visited.last.straightline_distance_to_landmark(l)
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
  
  def straightline_distance_to_next_stop(units='miles')
    if self.next_stop
      self.landmark.straightline_distance_to_landmark(self.next_stop.landmark)
      # start = Geokit::LatLng.new(lat=self.landmark.latitude,lng=self.landmark.longitude)
      # target = Geokit::LatLng.new(lat=self.next_stop.landmark.latitude,lng=self.next_stop.landmark.longitude)
      # if units == 'miles'
      #   start.distance_to(target, :units => :miles)
      # elsif units == 'feet'
      #   start.distance_to(target, :units => :miles) * 5280
      # elsif units == 'kilometers'
      #   start.distance_to(target, :units => :kms)
      # elsif units == 'meters'
      #   start.distance_to(target, :units => :kms) * 1000 
      # end
    else
      nil
    end
  end
  
  ###
    # ESTIMATED STRAIGHTLINE DISTANCE
    ###
  def estimated_straightline_distance_from_previous_stop(units='miles')
    if self.previous_stop
      dde = self.previous_stop.landmark_visit.direction_distance_estimates.where(:target_landmark_id => self.landmark.id).first
      return nil if !dde
      
      if dde.distance_estimate_units == 'miles'
        distance_estimate_in_miles = dde.distance_estimate
      elsif dde.distance_estimate_units == 'feet'
        distance_estimate_in_miles = dde.distance_estimate / 5280
      elsif dde.distance_estimate_units == 'kilometers'
        distance_estimate_in_miles = dde.distance_estimate * 0.621371192
      elsif dde.distance_estimate_units == 'meters'
        distance_estimate_in_miles = dde.distance_estimate * 0.000621371192
      end        
      
      if units == 'miles'
        distance_estimate_in_miles
      elsif units == 'feet'
        distance_estimate_in_miles * 5280
      elsif units == 'kilometers'
        distance_estimate_in_miles * 1.609344
      elsif units == 'meters'
        distance_estimate_in_miles * 1.609344 * 1000
      end
    else
      return nil
    end
  end
  
  def estimated_straightline_distance_to_next_stop(units='miles')
    if self.next_stop
      dde = self.landmark_visit.direction_distance_estimates.where(:target_landmark_id => self.next_stop.landmark.id).first
      
      if dde.distance_estimate_units == 'miles'
        distance_estimate_in_miles = dde.distance_estimate
      elsif dde.distance_estimate_units == 'feet'
        distance_estimate_in_miles = dde.distance_estimate / 5280
      elsif dde.distance_estimate_units == 'kilometers'
        distance_estimate_in_miles = dde.distance_estimate * 0.621371192
      elsif dde.distance_estimate_units == 'meters'
        distance_estimate_in_miles = dde.distance_estimate * 0.000621371192
      end        
      
      if units == 'miles'
        distance_estimate_in_miles
      elsif units == 'feet'
        distance_estimate_in_miles * 5280
      elsif units == 'kilometers'
        distance_estimate_in_miles * 1.609344
      elsif units == 'meters'
        distance_estimate_in_miles * 1.609344 * 1000
      end
    else
      return nil
    end
  end
  
  def estimated_straightline_distance_from_previous_stop_rank  
    if self.landmarks_already_visited.length == 0
      return nil
    else
      landmarks_left_to_visit_with_cog_distances = []
      self.landmarks_left_to_visit.each do |l|
        dde = DirectionDistanceEstimate.find(:first, :conditions => ["start_landmark_id = ? and target_landmark_id = ?", self.landmarks_already_visited.last.id, l.id])
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
  
  ###
    # RANKS
    ###
  def landmarks_already_visited
    landmarks_already_visited = []
    self.tsp_game.user.landmark_visits.find(:all, :conditions => ["created_at < ?", self.landmark_visit.created_at]).each do |lv|
      landmarks_already_visited << lv.landmark
    end
    landmarks_already_visited
  end
  
  def landmarks_left_to_visit
    self.tsp_game.user.landmarks - self.landmarks_already_visited
  end
  
end