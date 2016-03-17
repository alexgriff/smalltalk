# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


topics = ["Politics", "Sports", "Celebrity Gossip", "Weather", "Art"]


FactoryGirl.define do
  factory :topic do
    name topics.sample
  end
end
