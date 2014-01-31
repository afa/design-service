class WorksheetEducation < ActiveRecord::Base
	belongs_to :worksheet, class_name: 'Worksheet', foreign_key: 'worksheet_id'
end
