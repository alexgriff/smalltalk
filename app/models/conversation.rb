# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  partner_id :integer
#  time       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :partner
  has_one :review, dependent: :destroy
  has_many :conversation_topics
  has_many :topics, through: :conversation_topics
  accepts_nested_attributes_for :review

  validates :time, presence: {message: "Must provide a date for the convo"}
  validates :review, presence: {message: "Must provide a rating for the convo"}

  


  def associate_or_create_partner_by_name(name)
    if self.user.partners.find_by(name: name)
      partner = user.partners.find_by(name: name)
    else
      self.partner = Partner.create(name: name)
    end
  end
  
  #conversations within a month
  def self.this_month 
    where(time: 1.month.ago..Time.now)
  end 
  
  #5 most recent conversations
  def self.most_recent
   self.order('time DESC').first(5)
  end 
  
  #conversations with ratings >=4
  def self.high_ratings
    joins(:review).merge(Review.high_ratings)
  end 
  
  #conversations wiith ratings <=1
  def self.low_ratings
    joins(:review).merge(Review.low_ratings)
  end 

  #Need to Test
  #conversation that the user had with male/female partner
  def self.with_male_partner
    where(partner: Partner.male)
  end 
  
  def self.with_female_partner
    where(partner: Partner.female)
  end 
   
   #Topic of the converstions
   def self.topics
     ConversationTopic.where(conversation: self.all).pluck(:topic_id).map do 
     |id| Topic.find(id) end.uniq 
   end 

 
end
