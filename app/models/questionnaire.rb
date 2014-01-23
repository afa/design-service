# coding: utf-8
class Questionnaire < ActiveRecord::Base
	belongs_to :specialization, class_name: 'Specialization', foreign_key: 'specialization_id'

	has_and_belongs_to_many :questionnaire_fields

	has_many :questionnaire_fields_questionnaires

	# назначается новое поле и устонавливаются его детали по умолчанию
	def add_field(questionnaire_field_id)
		questionnaire_field = QuestionnaireField.find(questionnaire_field_id)
		self.questionnaire_fields << questionnaire_field
		self.save

		last_questionnaire_field = self.questionnaire_fields_questionnaires.where("location = 'left'").order("position asc").last
		unless last_questionnaire_field.nil?
			last_position = last_questionnaire_field.position.to_i + 1
		else
			last_position = 1
		end
		
		data = QuestionnaireFieldsQuestionnaire.last
		data.update_attributes(:position => last_position,
			:location => 'left', 
			:is_necessarily => true,
			:value => "")
	end
end