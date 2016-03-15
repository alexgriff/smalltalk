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
end
