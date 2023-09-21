# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin_user = User.create!(
  username: "admin",
  password: "adminpassword",
  role: "admin",
  status: "approved"
)

user1 = User.create!(
  username: "fred",
  password: "password",
  role: "user",
  status: "approved"
)

user1 = User.create!(
  username: "frank",
  password: "password",
  role: "user",
  status: "approved"
)

agent1 = User.create!(
  username: "frida",
  password: "password",
  role: "agent",
  status: "pending"
)

agent2 = User.create!(
  username: "frangelica",
  password: "password",
  role: "agent",
  status: "pending"
)