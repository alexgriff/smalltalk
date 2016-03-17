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

FactoryGirl.define do
  factory :conversation do
    user_id { Faker::Number.between(1, 100) }
    partner_id { Faker::Number.between(1, 100) }
    time { Faker::Time.between(2.years.ago, Time.now, :all) }
  end
end


