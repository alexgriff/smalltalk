User.create(name: "Sam", awkwardness: 8, fun_fact:"loves Taylor Swift")
User.create(name: "Nami", awkwardness: 9, fun_fact:"likes to talk about North Korea")
User.create(name: "Alex", awkwardness: 6, fun_fact:"enjoys akward conversations")
User.create(name: "Jeff", awkwardness: 5, fun_fact:"jumping jeff")

Partner.create(name: "Billy", age:19, gender:"M")
Partner.create(name: "Ian", age:23, gender:"M")
Partner.create(name:"Kaitlin", age:34, gender:"F")

Conversation.create(user: User.all[0], partner: Partner.all[0])
Conversation.create(user: User.all[1], partner: Partner.all[1])


config_path = File.expand_path("../topics_file.txt", __FILE__)
f = File.open(config_path) or die "Unable to open file..."
 
  f.each_line {|line|
    Topic.create(name: line)
  }

