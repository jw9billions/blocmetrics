test1 = User.create!(
  email: 'test1@test.com',
  password: 'password'
)

test2 = User.create!(
  email: 'test2@test.com',
  password: 'password'
)

test3 = User.create!(
  email: 'test3@test.com',
  password: 'password'
)

users = User.all

10.times do
  RegisteredApplication.create!(
    name: Faker::App.name,
    url: Faker::Internet.url,
    user: users.sample
  )
end

registered_applications = RegisteredApplication.all

#sample events
event_list = ['eat', 'drink', 'sleep', 'six']

100.times do
  Event.create!(
    name: event_list.sample,
    registered_application: registered_applications.sample
  )
end

events = Event.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered applications created"
puts "#{Event.count} events created"
