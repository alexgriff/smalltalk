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

genders = ["male", "female"]

FactoryGirl.define do
  factory :partner do
    name { Faker::Name.name }
    gender genders.sample
    age { Faker::Number.between(1,120)}
  end
end

