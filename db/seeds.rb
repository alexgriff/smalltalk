
# Init Topics
config_path = File.expand_path("../topics_file.txt", __FILE__)
f = File.open(config_path) or die "Unable to open file..."
 
  f.each_line {|line|
    Topic.create(name: line)
  }


# 25 users, 25 conversations with 25 reviews, 25 partners
25.times do
  convo=FactoryGirl.build :conversation
  
  
  convo.topics << Topic.all.sample(rand(1..4))
  convo.save
end


# make each user have some more conversations
10.times do
  
  User.all.each do |user|
    rand(0..9).times do
      convo = Conversation.new(user: user, partner: Partner.all.sample)
      convo.review = FactoryGirl.create :review
      convo.time = Faker::Time.between(1.month.ago, Time.now)
      
  
      convo.topics << Topic.all.sample(rand(1..4))
      convo.save
    end
    user.save
  end
  
end


