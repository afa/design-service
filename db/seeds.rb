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

{ hallway: 'Концепция прихожей',
  bedroom: 'Концепция спальни',
  living_room: 'Концепция гостиной',
  color_solutions: 'Цветовые решения (идеи сочетаний)',
  child_room: 'Концепция детской комнаты',
  bathroom: 'Концепция санузла',
  kitchen: 'Концепция кухни',
  kitchen_plus_living_room: 'Концепция кухни+гостиной',
  lounges: 'Концепция комнаты отдыха',
  cabinet: 'Концепция кабинета',
  sweep_wall: 'Развертки стен',
  floor_plans: 'Планы полов',
  ceiling_fixtures: 'Планы потолков и освещение',
  draping_materials: 'Подбор отделочных материалов'
}.each do |typename, name|
  OrderCustomizer.create(typename: typename, name: name, image: 'concept.jpg', description: '')
end

[
  ['building_company', '', 'Строительные компании', 'Строительная компания'],
  ['building_brigade', '', 'Строительные бригады', 'Строительная бригада'],
  ['architector', '', 'Архитекторы', 'Архитектор'],
  ['designer', '', 'Дизайнеры', 'Дизайнер'],
  ['engineer', 'electricity', 'Инженеры', 'Инженер-электрик'],
  ['engineer', 'heating', 'Инженеры', 'Инженер по отоплению'],
  ['engineer', 'ventilation', 'Инженеры', 'Инженер по вентиляции'],
  ['engineer', 'canalization', 'Инженеры', 'Инженер по водоснабжению и канализации'],
  ['engineer', 'weak_current', 'Инженеры', 'Инженер по слаботочным системам'],
  ['engineer', 'constructor', 'Инженеры', 'Инженер-конструктор']
].each do |name,sub_name, group_title, title|
  Specialization.where(name: name, sub_name: sub_name).first_or_create{|s| s.group_title = group_title; s.title = title; }
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
  u.build_specialist(bio_info: 'Родился, жил, помер', work_info: 'Работал, работал, работал')
end
spec_2 = User.where(username: 'injener_4to_nado', email: 'injener_4to_nado@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_profile(name: 'Александр', surname: 'Александров', middle_name: 'Александрыч', fake_name: 'ИнженерШоНадо')
  u.build_specialist(bio_info: 'Родился, жил, пил, курил', work_info: 'Пока космические корабли бороздят просторы Большого театра...')
end
spec_3 = User.where(username: 'belyi_vorona', email: 'belyi_vorona@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_profile(name: 'Иван', surname: 'Александров', middle_name: 'Петрович', fake_name: 'БелыйВорон')
  u.build_specialist(bio_info: 'Еще не родился', work_info: 'Работал? вкалывал? кто-то другой')
end
spec_4 = User.where(username: 'gradus_marazma', email: 'gradus_marazma@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_profile(name: 'Градус', surname: 'Маразма', middle_name: 'Крепчал', fake_name: 'ПростоВася')
  u.build_specialist(bio_info: 'Я жил, забыл уж сколько тысяч лет', work_info: 'С гармошкой и с долотом')
end

spec_5 = User.where(username: 'marazma_gradus', email: 'marazma_gradus@test.com').first_or_create(password: 'password', password_confirmation: 'password') do |u|
  u.role = 'specialist'
  u.build_profile(name: 'Маразма', surname: 'Градус', middle_name: 'Крепчает', fake_name: 'ЙодаПростоЯ')
  u.build_specialist(bio_info: 'Лет тысяч сколько уж забыл, жил я', work_info: 'С бутылкою вина и с ложкой')
end


puts "specialists created:\n#{spec_1}\n#{spec_2}\n#{spec_3}\n#{spec_4}\n"

group_1 = SpecialistGroup.where(name: 'Радуга', description: 'Покрашу усё', specialization_id: Specialization.where(name:'building_brigade').first.id, quality_rating: 6, reliability_rating: 'A').first_or_create
group_1.specialists << spec_1.specialist << spec_5.specialist

group_2 = SpecialistGroup.where(name: 'Суперкоманда', description: 'Сделаю нууу полный ремонт', specialization_id: Specialization.where(name:'engineer').first.id, quality_rating: 4, reliability_rating: 'B').first_or_create
group_2.specialists << spec_2.specialist << spec_5.specialist

group_3 = SpecialistGroup.where(name: 'Дизайнутые дизайнёры', description: 'Сабж, как и было сказано', specialization_id: Specialization.where(name:'designer').first.id, quality_rating: 5, reliability_rating: 'D').first_or_create
group_3.specialists << spec_3.specialist << spec_4.specialist << spec_5.specialist

group_4 = SpecialistGroup.where(name: 'Винни Пух и все-все-все', description: 'Ну мы всё могём, ага!', specialization_id: Specialization.where(name:'architector').first.id, quality_rating: 9, reliability_rating: 'A').first_or_create
group_4.specialists << spec_1.specialist << spec_2.specialist << spec_3.specialist << spec_4.specialist << spec_5.specialist

group_5 = SpecialistGroup.where(name: 'Йода-да-да-та-да-дам', description: 'Йода я, персоной своей, в бочке затычка в каждой', specialization_id: Specialization.where(name:'building_company').first.id, quality_rating: 1, reliability_rating: 'F').first_or_create
group_5.specialists << spec_5.specialist


portfolio_items = (1..15).map{|i| upload_portfolio_item "./db/seeds/designers_works/#{i}.jpg" }

portfolio_1 = Portfolio.create(name: 'Как я отделал шалаш', description: 'Читай сабж') {|p| 
  p.specialist = spec_1.specialist
  p.portfolio_items << portfolio_items[13] << portfolio_items[14]
}

###
portfolio_2 = Portfolio.create(name: 'Как я построил плотину', description: 'Читай сабж') {|p|
  p.specialist = spec_2.specialist
  p.portfolio_items << portfolio_items[6] << portfolio_items[7] << portfolio_items[8]
}
portfolio_3 = Portfolio.create(name: 'Как я обустроил мир', description: 'Читай сабж') {|p|
  p.specialist = spec_2.specialist
  p.portfolio_items << portfolio_items[9] << portfolio_items[10] << portfolio_items[11] << portfolio_items[12]
}

portfolio_4 = Portfolio.create(name: 'Как я отделал хату', description: 'Читай сабж') {|p|
  p.specialist = spec_3.specialist
  p.portfolio_items << portfolio_items[0] << portfolio_items[1] << portfolio_items[2] 
}

portfolio_5 = Portfolio.create(name: 'Как я отделал избу', description: 'Читай сабж') {|p| 
  p.specialist = spec_4.specialist
  p.portfolio_items << portfolio_items[3] << portfolio_items[4] << portfolio_items[5]
}
###

portfolio_for_group_1 = Portfolio.create(name: 'Цветной мир', description: 'Читай сабж') {|p|
  p.specialist_group = group_1
  p.portfolio_items << portfolio_items[13] << portfolio_items[14]
}
portfolio_for_group_2 = Portfolio.create(name: 'Арматура то да сё', description: 'Читай сабж') {|p|
  p.specialist_group = group_2
  p.portfolio_items << portfolio_items[7] << portfolio_items[9]
}

portfolio_for_group_3_1 = Portfolio.create(name: 'Отделанные домики', description: 'Читай сабж') {|p|
  p.specialist_group = group_3
  p.portfolio_items << portfolio_items[0] << portfolio_items[1] << portfolio_items[4] << portfolio_items[5]
}
portfolio_for_group_3_2 = Portfolio.create(name: 'Отделанные баньки', description: 'Читай сабж') {|p|
  p.specialist_group = group_3
  p.portfolio_items << portfolio_items[2] << portfolio_items[3]
}

portfolio_for_group_3_main = Portfolio.create(name: 'Всё подряд', description: 'Читай сабж') {|p|
  p.specialist_group = group_3
  p.portfolio_items << portfolio_items[0] << portfolio_items[1] << portfolio_items[3]
}

###
puts 'portfolios with items created'
