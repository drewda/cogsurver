class GpsAccuracyMeasure < ActiveRecord::Base
  belongs_to :user
  
  def error_in_meters
    measured = Geokit::LatLng.new(lat=measured_latitude,lng=measured_longitude)
    specified = Geokit::LatLng.new(lat=specified_latitude,lng=specified_longitude)
    measured.distance_to(specified, :units => :kms) * 1000 
  end
end