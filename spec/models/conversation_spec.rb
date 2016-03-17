# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  partner_id :integer
#  time       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'



describe "Conversation" do

    let(:conversation) {FactoryGirl.create :conversation}
    let(:user) {FactoryGirl.create :user} 
  
    describe "initialization" do
      it 'is belongs to a user' do
       conversation = user.conversations.build
       conversation.save
        expect(conversation.user_id).to eq(user.id)
      end
    end

    describe "remove" do
      it 'should remove reviews if you delete user' do
        user = FactoryGirl.create(:user)
        conversation = user.conversations.build
        user.conversations.first.review = Review.new
        user.save
        conversation.destroy
          expect(Review.all.count).to eq(0)
        end
    end


      
# remove a conversation and there should be one fewer review


end