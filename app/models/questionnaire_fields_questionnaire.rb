# coding: utf-8
class QuestionnaireFieldsQuestionnaire < ActiveRecord::Base

	belongs_to :questionnaire, class_name: 'Questionnaire', foreign_key: 'questionnaire_id'
	belongs_to :questionnaire_field, class_name: 'QuestionnaireField', foreign_key: 'questionnaire_field_id'

	has_many :worksheet_fields

	extend Enumerize
  	enumerize :kinds, in: ['first_name', 'last_name', 'patronymic', 'phone', 'email']
end