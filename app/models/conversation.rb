# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  partner_id :integer
#  time       :date
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
  

end
