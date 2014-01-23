# coding: utf-8
class Question < ActiveRecord::Base
	belongs_to :questionnaire, class_name: 'Questionnaire', foreign_key: 'questionnaire_id'

	has_many :question_fields
end
