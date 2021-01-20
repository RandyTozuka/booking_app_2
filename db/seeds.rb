# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# timeframesにslotを入れる
Timeframe.create!(slot: '11:30~11:45')
Timeframe.create!(slot: '11:45~12:00')
Timeframe.create!(slot: '12:00~12:15')
Timeframe.create!(slot: '12:15~12:30')
Timeframe.create!(slot: '12:30~12:45')
Timeframe.create!(slot: '12:45~13:00')
Timeframe.create!(slot: '13:00~13:15')
Timeframe.create!(slot: '13:15~13:30')

# admin user を設定する
# 参考：https://qiita.com/day-1/items/8eb903fcf083b30a17a4
# 参考：https://stackoverflow.com/questions/12418584/seeding-users-with-devise-in-ruby-on-rails
user = User.new(
  email: 'testman0@test.com',
  password: 'testman0',
  password_confirmation: 'testman0',
  admin: "true"
)
user.save

# 複数人の user を作る
# 参考:https://qiita.com/takehanKosuke/items/79a66751fe95010ea5ee
5.times do |n|
  user = User.new(
    email: "testman#{n+1}@test.com",
    password: "testman#{n+1}",
    password_confirmation: "testman#{n+1}"
  )
  user.save
end
