# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
#
# group = Group.create!(name: "PZPI-16-4")
# user1 = Visitor.create!(first_name: "Eduard", last_name: "Bekir", group: group, password_digest: "111111", role: "student", email: "eduard.bekir.prog@gmail.com")
# user2 = Visitor.create!(first_name: "Julia", last_name: "Lokteva", group: group, password_digest: "111111", role: "student", email: "julia.lokteva.prog@gmail.com")
# user3 = Visitor.create!(first_name: "Eduard", last_name: "Bekir", group: group, password_digest: "111111", role: "student", email: "maksym.achkasov.prog@gmail.com")
#
#
# group = Group.create!(name: "PZPI-16-3")
# Visitor.create!(first_name: "Eduard", last_name: "Bekir", group: group, password_digest: "111111", role: "student", email: "some1.prog@gmail.com")
# Visitor.create!(first_name: "Julia", last_name: "Lokteva", group: group, password_digest: "111111", role: "student", email: "some2.prog@gmail.com")
# Visitor.create!(first_name: "Eduard", last_name: "Bekir", group: group, password_digest: "111111", role: "student", email: "some3.prog@gmail.com")
#
# teacher = Visitor.create(first_name: "Victoria", last_name: "Mazurova", role: "teacher", password_digest: "111111", email: "mazurova@gmail.com")
#
# subject = Subject.create!(name: "ARKPZ", students: [user1, user2, user3], teachers: [teacher])
#
# Schedule.create!(subject: subject, teacher: teacher)

10.times do
  Visitor.new(bssid: [Bssid.new(name: "some_bssid")], email: Faker::Internet.email, first_name: Faker::FunnyName.name, last_name: Faker::FunnyName.name, password: Faker::Compass.cardinal).save
end
