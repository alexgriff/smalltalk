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

FactoryGirl.define do
  factory :partner do
    name "MyString"
    gender "MyString"
    age 1
  end
end
