# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ActiveRecord::Base
  has_many :conversation_topics
  has_many :conversations, through: :conversation_topics
  has_many :users, through: :conversations
  has_many :partners, through: :conversations 
  has_many :reviews, through: :conversations



  #topic's average rating by all users
  def average_rating
    if self.reviews.count != 0
    self.reviews.pluck(:rating).sum / self.reviews.count
    else 0 
    end 
  end

  # most successful conversation topic   
  def self.with_highest_rating
     self.all.max_by {|topic| topic.average_rating}
  end  

  # # most frequent topic by all users
  # def self.most_frequent_topic
  # end 

  # def self.least_rated_topic_by_users
  # end  



end
