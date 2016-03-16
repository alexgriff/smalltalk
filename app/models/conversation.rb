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
  has_one :review 
  has_many :conversation_topics
  has_many :topics, through: :conversation_topics
  accepts_nested_attributes_for :review
  

end
