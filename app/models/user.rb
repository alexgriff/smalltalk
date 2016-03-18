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

###### Partner Methods #######
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
    (100 * (num_convos_about_topic.to_f/total_convos_with)).round(2)
  end

  def topic_count_with(partner)
    binding.pry
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

  def average_rating(partner)
    all_ratings = self.conversations.where(partner: partner).map do |convo|
      if convo.review 
        convo.review.rating
      end
    end.compact
    (all_ratings.sum.to_f/all_ratings.count).round(2)
  end

###### Topic Methods #######
  def topic_count(topic)
      self.topics.where(id: topic.id).count
  end

  def total_topic_count
    count_hash = Hash.new(0)
    self.topics.each do |topic|
      name = topic.name
      count_hash[name] += 1
    end
    count_hash
  end

  def topic_count_for(topic)
    ((topic_count(topic).to_f/self.conversations.size) * 100).round(2)
  end
  


  # user's average rating of the given topic 
  def ave_rating(topic)
     reviews = self.reviews.select do |review| review.conversation.topics.include?(topic)
     end
     topic_ratings = reviews.map do |review| review.rating end   
      topic_ratings.sum.to_f / topic_ratings.size
  end  

  #returns user's reviews with rating >= 4
  def high_rated_reviews
    self.reviews.high_ratings
  end
  
  #returns array of most frequent conversation partners
  def most_frequent_convo_partners 
    partners = self.partner_ids 
    partners_with_most_frequency = partners.group_by{|x| partners.count(x)}.sort.last 
    frequency = partners_with_most_frequency.first
    partners_with_most_frequency.last.uniq.map do |id| Partner.find(id) end  
  end  

  #returns converesations that the user had this month
  def conversation_this_month
    self.conversations.this_month
  end
  
  #conversations with high rating 
  def conversations_with_high_rating
   self.conversations.high_ratings
  end 
  
  #conversation with low_rating
  def conversations_with_low_rating
    self.conversations_with_low_rating
  end

  def array_of_ratings_by_user
    self.reviews.map do |review|
      review.rating
    end 
  end 

  def average_rating_for_topic(topic)
    reviews_with_given_topic = self.reviews.select do |review| 
      review.conversation.topics.include?(topic)
     end
    if reviews_with_given_topic.present?
      ratings = reviews_with_given_topic.map { |review| review.rating } 
      (ratings.sum.to_f / ratings.size).round(2)
    else
      0
    end

  end 
  

end

