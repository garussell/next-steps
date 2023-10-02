# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Admin Users Manual Login
admin_user = User.create!(
  username: "admin",
  password: "adminpassword",
  role: "admin",
  status: "approved"
)
puts "admin_user created"

# Users
user1 = User.create!(
  username: "fred",
  password: "password",
  role: "user",
  status: "approved"
)
puts "user1 created"
user2 = User.create!(
  username: "frank",
  password: "password",
  role: "user",
  status: "approved"
)
puts "user2 created"
agent1 = User.create!(
  username: "frida",
  password: "password",
  role: "agent",
  status: "pending",
  description: "I have 2 rooms available for previous offenders"
)
puts "agent1 created"
agent2 = User.create!(
  username: "frangelica",
  password: "password",
  role: "agent",
  status: "pending",
  description: "I own a group home and accept vouchers"
)
puts "agent2 created"

