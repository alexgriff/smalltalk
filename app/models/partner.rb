# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string
#  gender     :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Partner < ActiveRecord::Base
  has_many :conversations 
  has_many :reviews, through: :conversations
  has_many :users, through: :conversations
  has_many :topics, through: :conversations 

#returns the topic of conversation that has highest rating
 def topic_highest_rating
   self.topics.with_highest_rating
 end 

#returns average age
 def self.ave_age
   age_all = self.pluck(:age).compact
   age_all.sum / age_all.count 
 end 

#female partners of the conversation list 
 def self.female
  where(gender: "F")  
 end 

#male partners of the conversation list 
 def self.male
  where(gender: "M")
 end 

 def most_frequent_topic
   self.topics.most_frequent
 end  

 def highest_rated_topic
    self.reviews.max_by {|topic| topic.average_rating} 
 end 
 

end

