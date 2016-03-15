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

require 'rails_helper'

RSpec.describe ConversationTopic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
