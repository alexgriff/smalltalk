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

require 'rails_helper'

describe "Partners" do

    let(:conversation) {FactoryGirl.create :conversation}
    let(:user) {FactoryGirl.create :user} 
    let(:partner) {FactoryGirl.create :partner} 
  
    describe "instance methods" do
      it 'it knows the most frequently discussed topic' do
       user = FactoryGirl.create(:user)
       conversation = user.conversations.create
       conversation2 = user.conversations.create
       Topic.create(name: "Politics")
       Topic.create(name: "Art")
       user.conversations.first.topics << Topic.first
       user.conversations.first.topics << Topic.second
       user.conversations.last.topics << Topic.first
        expect(Conversation.most_frequent).to eq(Topic.find_by(:name => "Politics"))
     end
    end
end


