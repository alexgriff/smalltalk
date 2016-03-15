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

class ConversationTopic < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :topic 
end
