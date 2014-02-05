# coding: utf-8
class QuestionnaireField < ActiveRecord::Base
	has_and_belongs_to_many :questionnaires

	has_many :questionnaire_fields_questionnaires

	extend Enumerize
  	enumerize :location, in: ['left', 'right', 'center_full']
end
