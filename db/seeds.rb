# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# # ユーザーを99人生成する
# 99.times do |n|
#   email = "example-#{n+1}@test.com"
#   password = "password"
#   User.create!(email: email, password: password,)
# end
#
# # ユーザーの一部を対象に予約を生成する
# users = User.order(:created_at).take(10)
# 50.times do
#   users.each { |user| user.bookings.create!(date:*** ), (slot:*** }
# end
