# coding: utf-8
class Question < ActiveRecord::Base
	belongs_to :questionnaire, class_name: 'Questionnaire', foreign_key: 'questionnaire_id'

	has_many :question_fields

	extend Enumerize
  	enumerize :kinds, in: ['photo_test', 'random_question', 'check_need', 'yes_no', 'add_files', 'experience_min', 'experience_max']

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
		question_fields.where("display = 'check_select' or display = 'check_value'").order("position asc")
	end

	def get_description_with_files
		question_fields.where("display = 'description_with_file'").order("id asc")
	end
end