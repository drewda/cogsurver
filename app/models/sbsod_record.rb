class SbsodRecord < ActiveRecord::Base
  belongs_to :user
  
  def reverse_code (input)
    reverse = case input
      when 1 then 7
      when 2 then 6
      when 3 then 5
      when 4 then 4
      when 5 then 3
      when 6 then 2
      when 7 then 1
    end
  end
  
  def total_score
    total_score = reverse_code(q1) + q2 + reverse_code(q3) + reverse_code(q4) + reverse_code(q5) + q6 + reverse_code(q7) + q8 + reverse_code(q9) + q10 + q11 + q12 + q13 + reverse_code(q14) + q15
  end
  
  def average_score
    average_score = total_score / 15.0
  end
end