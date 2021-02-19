# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: "testuser1", password: "password", email: "test@test.com")
Course.create(
  user_id: 1,
  title: "Intro to Ruby",
  description: "Sample course description. This description is longer. Than other descriptions. End description",
  rating: 5
)
Post.create(course_id: 1, title: "Test Post", content: "Hello World")
