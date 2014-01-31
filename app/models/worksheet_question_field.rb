class WorksheetQuestionField < ActiveRecord::Base
	belongs_to :worksheet, class_name: 'Worksheet', foreign_key: 'worksheet_id'
	
	has_one :attachment, as: :attachable, class_name: 'Attachment', dependent: :destroy
end
