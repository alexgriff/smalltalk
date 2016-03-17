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

require 'rails_helper'

