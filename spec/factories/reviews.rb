# == Schema Information
#
# Table name: reviews
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  rating          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  comment         :text
#

FactoryGirl.define do
  factory :review do
    rating {rand(1..5)}
    comment {Faker::Lorem.sentence}


    trait :really_bad_convo do
      rating 1
    end
  end
end
