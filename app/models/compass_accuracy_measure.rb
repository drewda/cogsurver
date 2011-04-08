class CompassAccuracyMeasure < ActiveRecord::Base
  belongs_to :user
  
  def error
    absolute_direction_error = (measured_direction_estimate - specified_direction_estimate).modulo(360) 
    if absolute_direction_error > 180
      absolute_direction_error = 360 - absolute_direction_error
    else
      absolute_direction_error
    end
  end
end