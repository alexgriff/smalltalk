# == Schema Information
#
# Table name: conversation_topics
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  topic_id        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :conversation_topic do
    conversation_id 1
    topic_id 1
  end
end
