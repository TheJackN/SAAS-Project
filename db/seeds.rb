include Faker

15.times do
  User.create!(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  password: Faker::Internet.password(8)
  )
end

users = User.all

50.times do
  Wiki.create!(
  title: Faker::Lorem.sentence,
  body: Faker::Lorem.paragraph,
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
