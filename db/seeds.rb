# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {
    first_name: "John",
    last_name: "Kratom",
    email: "jk@gmail.com",
    password_digest: BCrypt::Password.create('music')
  },
  {
    first_name: "Sara",
    last_name: "Connor",
    email: "sc@gmail.com",
    password_digest: BCrypt::Password.create('music')
  },
  {
    first_name: "Luis",
    last_name: "Rosario",
    email: "lr@gmail.com",
    password_digest: BCrypt::Password.create('music')
  }
  ])
