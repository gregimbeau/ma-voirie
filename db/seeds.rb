require 'faker'

Report.delete_all
User.delete_all

photo_files = Dir.glob(Rails.root.join('app', 'assets', 'images', 'seed_report_images', '*.jpg'))


User.create(nickname: "compte supprimé", email: "test@test.fr", password: "password", is_admin: true)

2.times do
  user = User.create!(
    nickname: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    is_admin: false
  )
end

5.times do
  report = Report.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.characters(number: 35),
    is_validate: nil,
    address: Faker::Address.street_address,
    user_id: User.all.sample.id,
    status: 0
  )

    selected_images = photo_files.sample(rand(1..3))

    selected_images.each do |image_file|
      report.images.attach(io: File.open(image_file), filename: File.basename(image_file))
    end
end