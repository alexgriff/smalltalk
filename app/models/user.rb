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
    count_hash = Hash.new(0)
    all_topics_with(partner).each do |topic|
      name = topic.name
      count_hash[name] += 1
    end
    count_hash
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


  def partner_highest_rating
    if self.conversations.present?
      self.partners.max_by {|partner| self.average_rating(partner)}
    end
  end 

   def highest_rated_topic_with(partner)
      
      # all the topics discussed in conversations that a specific partner was involved in
      #
      all_topics_with_partner = self.conversations.where(partner: partner).topics
      
      # will return a hash mapping ratings to a topic 
      # i.e. { 2.5 => <Topic name:"Politics"..>, 1.7 => <Topic name:"Entertainment"..>, 
      # 3.4 => <Topic name: "Random"..>, .. }
      #
      avg_rating_to_topic_map = 
        all_topics_with_partner.each_with_object({}) do |topic, avg_map|
          
          convos_for_topic = topic.conversations.where(user: self, partner: partner)

          topic_rating_avg = ((convos_for_topic.map(&:review).sum(&:rating)).to_f/convos_for_topic.size).round(2)

          avg_map[topic_rating_avg] = topic
      end

      # find the max key
      #
      max_rating = avg_rating_to_topic_map.keys.max

      # return both the rating and the value
      # [<Topic name:"Friendship">, 4.6]
      # so both can be accessed in the view
      #
      [avg_rating_to_topic_map[max_rating], max_rating]


   end

   def lowest_rated_topic_with(partner)
      
      # all the topics discussed in conversations that a specific partner was involved in
      #
      all_topics_with_partner = self.conversations.where(partner: partner).topics
      
      # will return a hash mapping ratings to a topic 
      # i.e. { 2.5 => <Topic name:"Politics"..>, 1.7 => <Topic name:"Entertainment"..>, 
      # 3.4 => <Topic name: "Random"..>, .. }
      #
      avg_rating_to_topic_map = 
        all_topics_with_partner.each_with_object({}) do |topic, avg_map|
          
          convos_for_topic = topic.conversations.where(user: self, partner: partner)

          topic_rating_avg = ((convos_for_topic.map(&:review).sum(&:rating)).to_f/convos_for_topic.size).round(2)

          avg_map[topic_rating_avg] = topic
      end

      # find the max key
      #
      min_rating = avg_rating_to_topic_map.keys.min

      # return both the rating and the value
      # [<Topic name:"Friendship">, 4.6]
      # so both can be accessed in the view
      #
      [avg_rating_to_topic_map[min_rating], min_rating]


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


 
  def all_conversations_about(topic)
    self.conversations.joins(:topics).where(topics: {id: topic.id})
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
  def conversations_this_month
    self.conversations.this_month
  end
  
  #conversations with high rating >=4
  def conversations_with_high_rating
    if self.conversations.present?
      self.conversations.high_ratings
    end
  end 
  
  #conversation with low_rating =< 1
  def conversations_with_low_rating
    self.conversations.low_ratings
  end
 
  #all the rating 
  def rating_list
   self.reviews.pluck(:rating)
  end 

  #average rating of the given topic by the user
  def average_rating_for_topic(topic)
    total = self.conversations.joins(:topics).where(topics: {id: topic.id}).count
    if total == 0
      0
    else
      ratings = self.conversations.joins(:topics).where(topics: {id: topic.id}).map do |convo|
        convo.review.rating
      end
    end
    ((ratings.sum).to_f / total).round(2)
  end

   
    # most successful conversation topic   
  def highest_rated_topic
    if self.conversations.present?
      self.topics.max_by{|topic| self.average_rating_for_topic(topic)} 
    end
  end 
 
  # least succesful conversation topic   
  def lowest_rated_topic
    if self.conversations.present?
      self.topics.min_by{|topic| self.average_rating_for_topic(topic)}
    end
  end  

  def all_partners_with(topic)
    self.conversations.joins(:topics).where(topics: {id: topic.id}).map do |convo|
     convo.partner
   end.flatten.uniq
  end


end

