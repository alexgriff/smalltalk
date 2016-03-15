require 'spec_helper'


describe 'Conversation' do 
  it 'has a user' do
    user = User.new(name: "John")
    conversation = Conversation.new(user: user)

    expect(conversation.user).to eq(user)
  end
  
  it 'has a partner' do
  it 'has a time' do
  it 'has a review' do



end