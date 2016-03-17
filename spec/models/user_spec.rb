# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string
#  awkwardness           :integer
#  fun_fact              :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  email                 :string
#  password_digest       :string
#  password_confirmation :string
#

require 'rails_helper'
  
  describe "User" do

    let(:user) {create :user}
    
    describe "initialization" do
      it 'has a name' do
        expect(user.name).to be
      end

      it 'is invalid without a name' do
        expect(build(:user, name: nil)).to be_invalid
      end

      it 'has a unique email address' do
        user = build(:user, email: 'sam@test.com')
        user.save
        user2 = build(:user, email: 'sam@test.com')
        expect(user2.valid?).to be false
      end

      it 'is invalid without an email' do
        expect(user.email).to be
      end

      it 'is invalid without awkwardness' do
        expect(user.awkwardness).to be
      end

    end
  end
