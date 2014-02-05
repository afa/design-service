# coding: utf-8
class Question < ActiveRecord::Base
	belongs_to :questionnaire, class_name: 'Questionnaire', foreign_key: 'questionnaire_id'

	has_many :question_fields

	extend Enumerize
  	enumerize :kinds, in: ['photo_test', 'random_question', 'check_need', 'yes_no', 'add_files', 
  		'experience_min', 'experience_max', 'add_values']

	def add_field(display)
		question_field_last = self.question_fields.order("position asc").last
		if question_field_last.nil?
			last_position = 1
		else
			last_position = question_field_last.position + 1
		end

		data = QuestionField.new(:display => display, :position => last_position, :name => "Название вопроса", :value => "", :statis_is_true => false)
		self.question_fields << data
		self.save
	end

	def add_default
		self.name = ""
		self.position = 1
		self.count_true = 1
		self.count_all = 6
		self.save
	end

	# беруться нужное количество рандомных ответов ответов
	def get_photo_test_answers
		question_fields.where("display = 'photo_test'").order("RANDOM()").limit(count_all)
	end

	def get_check_need_answers
		question_fields.where("display = 'check_select' or display = 'check_value' or display = 'check_select_no_level'")\
			.order("position asc")
	end

	def get_description_with_files
		question_fields.where("display = 'description_with_file'").order("id asc")
	end

	# берется 1 рандомный ответ из question_fields, который является вопросом
	def get_random_question_from_answers
		question_fields.where("display = 'question_for_random_question'").order("RANDOM()").limit(1).first
	end

	def get_values
		question_fields.where("display = 'value'").order("id asc")
	end
end