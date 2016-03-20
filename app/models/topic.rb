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
  
  #percentage of the appearance 
  def percentage
    ((self.conversation_count.to_f/Conversation.count)*100).round(2) 
  end 

  # most frequent topic by all users
  def self.most_frequent
      self.all.max_by {|topic| topic.conversation_count}
  end 

  # highest rated topic by all users
  def self.highest_rating
   self.all.max_by {|topic| topic.average_rating} 
  end 

  def self.lowest_rating
    self.all.min_by {|topic| topic.average_rating}
  end 
  

end
