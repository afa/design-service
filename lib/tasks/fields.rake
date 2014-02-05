# coding: utf-8
namespace :questionarie do
	desc "Add 5 ankete"
	task :add_fields => :environment do
		QuestionField.destroy_all
		QuestionField.create(:id => 1, :name => 'Заголовок и текстовое поле', 'name_and_value')
		QuestionField.create(:id => 2, :name => 'Заголовок и дата', 'name_and_date')
		QuestionField.create(:id => 3, :name => 'Проживание', 'residence')
		QuestionField.create(:id => 4, :name => 'Фотография', 'user_photo')
		QuestionField.create(:id => 5, :name => 'Заголовок и длинное поле', 'name_and_value_full')
		QuestionField.create(:id => 6, :name => 'Заголовок и длинное textarea', 'name_and_textarea_full')
		QuestionField.create(:id => 7, :name => 'Образование', 'education')
	end
end