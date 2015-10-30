include RandomData

15.times do
  User.create!(
  name: RandomData.random_name,
  email: RandomData.random_email,
  password: RandomData.random_sentence
  )
end

users = User.all

50.times do
  Wiki.create!(
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph,
  user: users.sample,
  private: false
  )
end

admin = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: '12345678',
  role:     'admin'
)

standard = User.create!(
  name:     'Standard User',
  email:    'standard@example.com',
  password: '12345678'
)

premium = User.create!(
  name:     'Premium User',
  email:    'premium@example.com',
  password: '12345678',
  role:     'premium'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} Wikis created"
