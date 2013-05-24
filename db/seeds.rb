# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.where(username: 'admin', email: 'prijutme4ty@gmail.com').first_or_create(password: 'VerY_str0ng_p@ssword', password_confirmation: 'VerY_str0ng_p@ssword') do |u|
  u.role = 'admin'
end
puts "admin created\n"

client_1 = User.where(username: 'vasya_pupkin', email: 'vasya_pupkin@test.com').first_or_create(password: 'password', password_confirmation: 'password'){|u| u.role = 'client'}
client_2 = User.where(username: 'petya_pupkin', email: 'petya_pupkin@test.com').first_or_create(password: 'password', password_confirmation: 'password'){|u| u.role = 'client'}
puts "clients created:\n#{client_1}\n#{client_2}\n"

spec_1 = User.where(username: 'cool_malyar', email: 'cool_malyar@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_specialist(specialization: 'building_brigade')
end
spec_2 = User.where(username: 'injener_4to_nado', email: 'injener_4to_nado@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_specialist(specialization: 'engineer')
end
spec_3 = User.where(username: 'belyi_vorona', email: 'belyi_vorona@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_specialist(specialization: 'designer')
end
puts "specialists created:\n#{spec_1}\n#{spec_2}\n#{spec_3}\n"

group_1 = SpecialistGroup.where(name: 'Суперкоманда', description: 'Сделаем нууу полный ремонт').first_or_create
group_1.specialists << spec_1.specialist << spec_2.specialist

group_2 = SpecialistGroup.where(name: 'Эксклюзивный дизайн', description: 'Сабж, как и было сказано').first_or_create
group_2.specialists << spec_3.specialist
puts "specialist groups created:\n#{group_1.specialists}\n#{group_2.specialists}\n"

photos = 10.times.map{|i| Photo.new(photo: "photo_#{i}.png") }
collection_1 = PhotoCollection.create(name: 'photo album 1'){|c| c.photos << photos[0] << photos[1] << photos[2] }
collection_2 = PhotoCollection.create(name: 'photo album 2'){|c| c.photos << photos[3] << photos[4] << photos[5] }
collection_3 = PhotoCollection.create(name: 'photo album 3'){|c| c.photos << photos[6] << photos[7] << photos[8] }
collection_4 = PhotoCollection.create(name: 'photo album 4'){|c| c.photos << photos[9] }
puts 'photos and photo collection builded'
portfolio_item_1 = PortfolioItem.new(photo_collection: collection_1, specialist: :spec_1)
portfolio_item_2 = PortfolioItem.new(photo_collection: collection_2, specialist: :spec_1)
portfolio_item_3 = PortfolioItem.new(photo_collection: collection_3, specialist: :spec_2)
portfolio_item_4 = PortfolioItem.new(photo_collection: collection_4, specialist: :spec_3)
puts 'portfolio items buided'