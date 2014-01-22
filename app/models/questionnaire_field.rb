# coding: utf-8
class QuestionnaireField < ActiveRecord::Base
	has_and_belongs_to_many :questionnaires

	extend Enumerize
  	enumerize :location, in: ['left', 'right', 'center_full']

	# берем детали назначенного поля для шаблона анкеты
	def details(questionnaire_id)
		QuestionnaireField.select("questionnaire_fields_questionnaires.position, location, questionnaire_fields_questionnaires.value")\
			.joins("inner join questionnaire_fields_questionnaires on questionnaire_fields_questionnaires.questionnaire_field_id = questionnaire_fields.id")\
			.where("questionnaire_fields_questionnaires.questionnaire_field_id = ? and questionnaire_fields_questionnaires.questionnaire_id = ?", self.id, questionnaire_id).first
	end
end
