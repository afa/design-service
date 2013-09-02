# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def upload_portfolio_item(filename)
  PortfolioItem.create{|pi|
    File.open(filename) do |fp|
      pi.photo = fp
    end
  }
end

admin = User.where(username: 'admin', email: 'prijutme4ty@gmail.com').first_or_create(password: 'VerY_str0ng_p@ssword', password_confirmation: 'VerY_str0ng_p@ssword') do |u|
  u.role = 'admin'
  u.build_profile(name: 'Ilya', surname: 'Vorontsov', middle_name: 'E.', fake_name: 'Adminych')
end
puts "admin created\n"

client_1 = User.where(username: 'vasya_pupkin', email: 'vasya_pupkin@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'client'
  u.build_profile(name: 'Василий', surname: 'Пупкин', middle_name: 'Васильевич', fake_name: 'Васпупкиныч')
end
client_2 = User.where(username: 'petya_pupkin', email: 'petya_pupkin@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'client'
  u.build_profile(name: 'Петя', surname: 'Пупкин', middle_name: 'Васильевич', fake_name: 'Петпупкиныч')
end
puts "clients created:\n#{client_1}\n#{client_2}\n"

spec_1 = User.where(username: 'cool_malyar', email: 'cool_malyar@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_profile(name: 'Иван', surname: 'Иванов', middle_name: 'Иваныч', fake_name: 'КулМаляр')
  u.build_specialist(specialization: 'building_brigade')
end
spec_2 = User.where(username: 'injener_4to_nado', email: 'injener_4to_nado@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_profile(name: 'Александр', surname: 'Александров', middle_name: 'Александрыч', fake_name: 'ИнженерШоНадо')
  u.build_specialist(specialization: 'engineer')
end
spec_3 = User.where(username: 'belyi_vorona', email: 'belyi_vorona@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_profile(name: 'Иван', surname: 'Александров', middle_name: 'Петрович', fake_name: 'БелыйВорон')
  u.build_specialist(specialization: 'designer')
end
spec_4 = User.where(username: 'gradus_marazma', email: 'gradus_marazma@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_profile(name: 'Градус', surname: 'Маразма', middle_name: 'Крепчал', fake_name: 'ПростоВася')
  u.build_specialist(specialization: 'designer')
end

puts "specialists created:\n#{spec_1}\n#{spec_2}\n#{spec_3}\n#{spec_4}\n"

group_1 = SpecialistGroup.where(name: 'Радуга', description: 'Покрашу усё', specialization: 'building_brigade').first_or_create
group_1.specialists << spec_1.specialist

group_2 = SpecialistGroup.where(name: 'Суперкоманда', description: 'Сделаю нууу полный ремонт', specialization: 'engineer').first_or_create
group_2.specialists << spec_2.specialist

group_3 = SpecialistGroup.where(name: 'Дизайнутые дизайнёры', description: 'Сабж, как и было сказано', specialization: 'designer').first_or_create
group_3.specialists << spec_3.specialist << spec_4.specialist
puts "specialist groups created:\n#{group_1}\n#{group_1.specialists}\n\n#{group_2}\n#{group_2.specialists}\n\n#{group_3}\n#{group_3.specialists}\n"

portfolio_items = (1..15).map{|i| upload_portfolio_item "./db/seeds/designers_works/#{i}.jpg" }

portfolio_1 = Portfolio.create(name: 'Как я отделал шалаш', description: 'Читай сабж') {|c| c.owner = spec_1; c.portfolio_items << portfolio_items[13] << portfolio_items[14] }
spec_1.specialist.main_portfolio = portfolio_1

###
portfolio_2 = Portfolio.create(name: 'Как я построил плотину', description: 'Читай сабж') {|c| c.owner = spec_2; c.portfolio_items << portfolio_items[6] << portfolio_items[7] << portfolio_items[8] }
portfolio_3 = Portfolio.create(name: 'Как я обустроил мир', description: 'Читай сабж') {|c| c.owner = spec_2; c.portfolio_items << portfolio_items[9] << portfolio_items[10] << portfolio_items[11] << portfolio_items[12] }
spec_2.specialist.main_portfolio = portfolio_3

portfolio_4 = Portfolio.create(name: 'Как я отделал хату', description: 'Читай сабж') {|c| c.owner = spec_3; c.portfolio_items << portfolio_items[0] << portfolio_items[1] << portfolio_items[2] }
spec_3.specialist.main_portfolio = portfolio_4

portfolio_5 = Portfolio.create(name: 'Как я отделал избу', description: 'Читай сабж') {|c| c.owner = spec_4; c.portfolio_items << portfolio_items[3] << portfolio_items[4] << portfolio_items[5] }
spec_4.specialist.main_portfolio = portfolio_5
###

portfolio_for_group_1 = Portfolio.create(name: 'Цветной мир', description: 'Читай сабж') {|c| c.owner = group_1; c.portfolio_items << portfolio_items[13] << portfolio_items[14] }
portfolio_for_group_2 = Portfolio.create(name: 'Арматура то да сё', description: 'Читай сабж') {|c| c.owner = group_2; c.portfolio_items << portfolio_items[7] << portfolio_items[9] }

portfolio_for_group_3_1 = Portfolio.create(name: 'Отделанные домики', description: 'Читай сабж') {|c| c.owner = group_3; c.portfolio_items << portfolio_items[0] << portfolio_items[1] << portfolio_items[4] << portfolio_items[5] }
portfolio_for_group_3_2 = Portfolio.create(name: 'Отделанные баньки', description: 'Читай сабж') {|c| c.owner = group_3; c.portfolio_items << portfolio_items[2] << portfolio_items[3] }

portfolio_for_group_3_main = Portfolio.create(name: 'Всё подряд', description: 'Читай сабж') {|c| c.owner = group_3; c.portfolio_items << portfolio_items[0] << portfolio_items[1] << portfolio_items[3] }

group_1.main_portfolio = portfolio_for_group_1
group_2.main_portfolio = portfolio_for_group_2
group_3.main_portfolio = portfolio_for_group_3_main
###
puts 'portfolios with items created'
