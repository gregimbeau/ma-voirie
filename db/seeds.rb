require 'faker'

Reply.delete_all
Comment.delete_all
Report.delete_all
User.delete_all
ReportLike.delete_all

photo_files = Dir.glob(Rails.root.join('app', 'assets', 'images', 'seed_report_images', '*.jpg'))

15.times do
  user = User.create!(
    nickname: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
  )
end

@address = ["1 Route d’Obermodern 67330 Bouxwiller","1 Rue de Bouxwiller 67330 Obermodern-Zutzendorf","1 Place du Château 67330 Bouxwiller","25 Grand-Rue 67330 Bouxwiller","15 Chemin du Sable 67330 Obermodern-Zutzendorf","30 Allée des Charmes 67330 Bouxwiller","1 Rue de l'Anneau 67330 Bosselshausen","23 Rue des Grives 67330 Neuwiller-lès-Saverne","51 Rue Principale 67330 Ernolsheim-lès-Saverne","9 Quartier Romain 67330 Bouxwille"]

2.times do
  report = Report.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.characters(number: 35),
    is_validate: nil,
    address: @address.first,
    user_id: User.all.sample.id
  )
  @address.rotate!
  selected_images = photo_files.sample(rand(1..3))
  selected_images.each do |image_file|
    report.images.attach(io: File.open(image_file), filename: File.basename(image_file))
  end
end

@status = [1, 2, 3, 4]

8.times do
  report = Report.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.characters(number: 35),
    is_validate: true,
    address: @address.first,
    user_id: User.all.sample.id,
    status: @status.first
  )
  @address.rotate!
  @status.rotate!
  selected_images = photo_files.sample(rand(1..3))
  selected_images.each do |image_file|
    report.images.attach(io: File.open(image_file), filename: File.basename(image_file))
  end
end

admin = User.create(nickname:ENV['ADMIN_NICKNAME'], email:ENV['ADMIN_EMAIL'], password:ENV['ADMIN_PASSWORD'])