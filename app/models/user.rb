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
  has_many :conversations
  has_many :partners, :through => :conversations
  has_many :reviews, :through => :conversations 
  has_many :topics, :through => :conversations
end
