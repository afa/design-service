# coding: utf-8
namespace :questionarie do
	desc "Add 5 ankete"
	task :add_fields => :environment do
		QuestionnaireField.destroy_all
		Question.destroy_all
		QuestionField.destroy_all
		Questionnaire.destroy_all
		QuestionnaireFieldsQuestionnaire.destroy_all

		QuestionnaireField.create(:id => 1, :name => 'Заголовок и текстовое поле', :display => 'name_and_value')
		QuestionnaireField.create(:id => 2, :name => 'Заголовок и дата', :display => 'name_and_date')
		QuestionnaireField.create(:id => 3, :name => 'Проживание', :display => 'residence')
		QuestionnaireField.create(:id => 4, :name => 'Фотография', :display => 'user_photo')
		QuestionnaireField.create(:id => 5, :name => 'Заголовок и длинное поле', :display => 'name_and_value_full')
		QuestionnaireField.create(:id => 6, :name => 'Заголовок и длинное textarea', :display => 'name_and_textarea_full')
		QuestionnaireField.create(:id => 7, :name => 'Образование', :display => 'education')
	end
end
