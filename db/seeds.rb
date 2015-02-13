require 'faker'

#Create Users
5.times do 
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Note: by calling 'User.new' instead of 'create',
# we create an instance of User which isn't immediately saved to the database.

# The 'skip_confirmation!' method sets the 'confirmed at' attribute
# to avoid triggering a confirmation email when the User is saved.

#The 'save' method then save this User to the database.

# Create Posts
50.times do
  Post.create!(
    user:   users.sample,
    title: Faker::Company.bs,
    body: Faker::Lorem.paragraph
    )
end

posts = Post.all

# Create Comments
100.times do
  Comment.create!(
    # user: users.sample,   #we have not yet associated Users with Comments
    post: posts.sample,
    body: Faker::Lorem.paragraph
    )
end

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
  email: 'emily@furlscrochet.com',
  password: 'emily1992'
  )

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"