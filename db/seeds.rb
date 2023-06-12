require 'faker'

Report.delete_all
User.delete_all


array_status = [
  "Validé",
  "Accepté",
  "En cours",
  "Résolu"
]

if Status.count == 0
  4.times do
    status = Status.create!(
    title: array_status.first 
    )
    array_status.rotate!
  end
end

2.times do
  user = User.create!(
    nickname: Faker::Name.first_name,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name, 
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    phone_number: Faker::PhoneNumber.phone_number,
    age: Faker::Number.within(range: 20..80),
    is_admin: false
  )
end

5.times do
  report = Report.create!(
    title: Faker::Book.title,
    content: Faker::Movie.quote,
    is_validate: nil,
    address: Faker::Address.street_address,
    user_id: User.all.sample.id,
    status_id: Status.all.sample.id
  )
end