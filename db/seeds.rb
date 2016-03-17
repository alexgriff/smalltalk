
# Init Topics
config_path = File.expand_path("../topics_file.txt", __FILE__)
f = File.open(config_path) or die "Unable to open file..."
 
  f.each_line {|line|
    Topic.create(name: line)
  }


# 25 users, 25 conversations with 25 reviews, 25 partners
25.times do
  convo=FactoryGirl.create :conversation
  
  rand(1..3).times do
    convo.topics << Topic.all.sample
  end
  convo.save
end

# make each user have some more conversations
2.times do
  
  User.all.each do |user|
    rand(0..9).times do
      convo = Conversation.create(user: user, partner: Partner.all.sample)
      convo.review = FactoryGirl.create :review
      rand(1..3).times do
        convo.topics << Topic.all.sample
      end
      convo.save
    end
    user.save
  end
  
end


