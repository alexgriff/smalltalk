# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string
#  awkwardness           :integer
#  fun_fact              :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  email                 :string
#  password_digest       :string
#  password_confirmation :string
#

class User < ActiveRecord::Base
  has_secure_password 

  has_many :conversations
  has_many :partners, :through => :conversations
  has_many :reviews, :through => :conversations 
  has_many :topics, :through => :conversations

  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email
  validates :awkwardness, presence: true


# look at all conversations
    # find the most discused conversation (group)
    # get and return count 

  def all_topics_with(partner)
    self.conversations.where(partner: partner).map do |convo|
      convo.topics
    end.flatten.uniq
  end

  def most_frequent_topic_with(partner)
    all_topics_with(partner).max
  end

  def number_of_conversations_about(topic)
    self.conversations.where(topic: topic).count
  end


  def number_of_conversations_with(partner)
    self.conversations.where(partner: partner).count
  end

  def most_frequent_partner
    # look at all conversations with ?
    binding.pry
  end

# self.conversations.where(partner: partner)
  # subset all users 






 

end
