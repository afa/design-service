# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new(username: 'admin', email: 'prijutme4ty@gmail.com', password: 'VerY_str0ng_p@ssword', password_confirmation: 'VerY_str0ng_p@ssword')
admin.role = 'admin'
admin.save