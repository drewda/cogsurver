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
  
  has_many :landmark_in_tsp_games
  has_many :tsp_stops, :through => :landmark_in_tsp_games

  def straightline_distance_to_landmark(target_landmark, units="miles")
    start = Geokit::LatLng.new(lat=self.latitude,lng=self.longitude)
    target = Geokit::LatLng.new(lat=target_landmark.latitude,lng=target_landmark.longitude)
    if units == 'miles'
      start.distance_to(target, :units => :miles)
    elsif units == 'feet'
      start.distance_to(target, :units => :miles) * 5280
    elsif units == 'kilometers'
      start.distance_to(target, :units => :kms)
    elsif units == 'meters'
      start.distance_to(target, :units => :kms) * 1000 
    end
  end

  def google_walking_route_distance_to_landmark(target_landmark, units="miles")
    ### cached google_route_distance for DissStudyOne ###
    cached_google_route_distances = [['Berkeley High School','CVS Pharmacy',0.255852],['Berkeley High School','Triple Rock Brewery and Alehouse',0.427869],['Berkeley High School','Berkeley Repertory Theatre',0.209277],['Berkeley High School','Au Coquelet',0.210519],['Berkeley High School','Jupiter',0.18009],['Berkeley High School','Starbucks',0.324162],['CVS Pharmacy','Triple Rock Brewery and Alehouse',0.419796],['CVS Pharmacy','Berkeley Repertory Theatre',0.321057],['CVS Pharmacy','Au Coquelet',0.442773],['CVS Pharmacy','Jupiter',0.171396],['CVS Pharmacy','Starbucks',0.308637],['Triple Rock Brewery and Alehouse','Berkeley Repertory Theatre',0.215487],['Triple Rock Brewery and Alehouse','Au Coquelet',0.214866],['Triple Rock Brewery and Alehouse','Jupiter',0.271998],['Triple Rock Brewery and Alehouse','Starbucks',0.344034],['Berkeley Repertory Theatre','Au Coquelet',0.145314],['Berkeley Repertory Theatre','Jupiter',0.191268],['Berkeley Repertory Theatre','Starbucks',0.245916],['Au Coquelet','Jupiter',0.317952],['Au Coquelet','Starbucks',0.373842],['Jupiter','Starbucks',0.145314]]
    cached_google_route_distances.find { |a| (a[0] == self.name and a[1] == target_landmark.name) or (a[1] == self.name and a[0] == target_landmark.name) }[2]
    
    # r = HTTParty.get("http://maps.googleapis.com/maps/api/directions/json?origin=#{self.latitude},#{self.longitude}" +
    #                  "&destination=#{target_landmark.latitude},#{target_landmark.longitude}" +
    #                  "&mode=walking&sensor=false")
    # j = Crack::JSON.parse(r.body)
    # p j
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
  end

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
