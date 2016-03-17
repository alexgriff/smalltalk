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


  def unique_topics_with(partner)
    all_topics_with(partner).uniq
  end

  def all_topics_with(partner)
    self.conversations.where(partner: partner).map do |convo|
      convo.topics
    end.flatten
  end

  def most_frequent_topic_with(partner)
    count_hash = topic_count_with(partner)
    name = count_hash.key(count_hash.values.max)
    Topic.find_by(name: name)
  end

  def topic_percentage_for_partner(partner, topic)
    total_convos_with = number_of_conversations_with(partner)
    num_convos_about_topic = topic_count_with(partner)[topic]
    100 * (num_convos_about_topic.to_f/total_convos_with)
  end

  def topic_count_with(partner)
    count_hash = Hash.new(0)
    all_topics_with(partner).each do |topic|
      name = topic.name
      count_hash[name] += 1
    end
    count_hash
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
