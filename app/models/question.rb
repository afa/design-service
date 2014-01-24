# coding: utf-8
class Question < ActiveRecord::Base
	belongs_to :questionnaire, class_name: 'Questionnaire', foreign_key: 'questionnaire_id'

	has_many :question_fields

	def add_field(display)
		question_field_last = self.question_fields.order("position asc").last
		data = QuestionField.new(:display => display, :position => (question_field_last.position + 1), :name => "", :value => "", :statis_is_true => false)
		self.question_fields << data
		self.save
	end
end
