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
    self.joins(:partner).merge(Partner.male)
  end 
  
  def self.with_female_partner
    self.joins(:partner).merge(Partner.female)
  end 

 
end
