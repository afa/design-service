class WorksheetExperience < ActiveRecord::Base
	belongs_to :worksheet, class_name: 'Worksheet', foreign_key: 'worksheet_id'
	belongs_to :question_field, class_name: 'QuestionField', foreign_key: 'question_field_id'
end