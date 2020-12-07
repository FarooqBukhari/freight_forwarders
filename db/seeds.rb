# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
25.times do
  user = User.new( name: Faker::Name.name_with_middle, job_title: Faker::Job.title, email: Faker::Internet.email, website: Faker::Internet.url, encrypted_password: '$2a$12$nTLaFMr/C59jtU4vshxPWutnuL9cditzcwWafRxH5ywh3q26eU6j2')
  user.save(validate: false )
end