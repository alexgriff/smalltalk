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

  def self.most_high_rated_topic_by_users
     
  end 

  def self.least_rated_topic_by_users

  end  
  has_many :partners, through: :conversations

end
