class TravelFix < ActiveRecord::Base
  belongs_to :user
  
  def distance_covered_between(other_travel_fix, units='miles')
    if other_travel_fix.created_at > self.created_at
      # other_travel_fix is later
      first_datetime = self.created_at
      last_datetime = other_travel_fix.created_at
    elsif other_travel_fix.created_at < self.created_at
      # other_travel_fix is first
      first_datetime = other_travel_fix.created_at
      last_datetime = self.created_at
    end
    distance_covered = 0
    travel_fixes = self.user.travel_fixes.where(:created_at => first_datetime..last_datetime)
    travel_fixes.each_cons(2) do |tfs|
      start = Geokit::LatLng.new(lat=tfs[0].latitude,lng=tfs[0].longitude)
      stop = Geokit::LatLng.new(lat=tfs[1].latitude,lng=tfs[1].longitude)
      if units == 'miles'
        distance_covered += start.distance_to(stop, :units => :miles)
      elsif units == 'feet'
        distance_covered += start.distance_to(stop, :units => :miles) * 5280
      elsif units == 'kilometers'
        distance_covered += start.distance_to(stop, :units => :kms)
      elsif units == 'meters'
        distance_covered += start.distance_to(stop, :units => :kms) * 1000
      end
    end
    distance_covered
  end
end