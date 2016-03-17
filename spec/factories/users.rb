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

FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    awkwardness { Faker::Number.between(1,10)}
    fun_fact { Faker::Hipster.word }
    sequence(:email) { |n| "first_name#{n}@idk.com".downcase }
    password_digest { "123" }
    password_confirmation { "123"}
  end
end
