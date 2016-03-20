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
      ((self.reviews.pluck(:rating).sum).to_f / self.reviews.count).round(2)
    else 
      0 
    end 
  end

  #counts the total number of conversation about the topic
  def conversation_count 
     self.conversations.count 
  end   

  # most frequent topic by all users
  def self.most_frequent
      self.all.max_by {|topic| topic.conversation_count}
  end 
  
  # least succesful conversation topic   
  def self.lowest_rated
      self.all.min_by {|topic| topic.average_rating}
  end  

  # most successful conversation topic   
  def self.highest_rated
     self.all.max_by {|topic| topic.average_rating}
  end  

end
