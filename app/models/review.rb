# == Schema Information
#
# Table name: reviews
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  rating          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  comment         :text
#

class Review < ActiveRecord::Base
  belongs_to :conversation 

  def review_message
    one_star = ["This conversation will haunt your dreams", "You are very traumatized"]
    two_star = ["You are slightly traumatized"]
    three_star = ["This conversation went okay"]
    four_star = ["You were sort of interested, great job!"]
    five_star = ["You're a rockstar. You should be as social networker"]
    case rating
      when 1 
        one_star.sample
      when 2 
        two_star.sample
      when 3 
        three_star.sample
      when 4 
        four_star.sample
      when 5 
        five_star.sample
    end 
  end

end
