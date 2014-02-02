# coding: utf-8
class WorksheetEducation < ActiveRecord::Base
	belongs_to :worksheet, class_name: 'Worksheet', foreign_key: 'worksheet_id'

	def get_status_necessarily(value)
		field = value.first.split('-')
		index_id = field.last.to_i
		field_name = field.first
		status = "success"

		if !field_name.at("type").nil?
			fields = field_name.split('_')
			#fields -= fields.last

			str = ""
			fields.each_with_index do |val, index|
				str += val if index < fields.size - 1
			end

			status = "success"
        	field = nil

			begin
            	field = QuestionnaireFieldsQuestionnaire.find(index_id)
	        rescue
	            status = "error_field"
	        end

	        unless field.nil?
	            if field.is_necessarily && (value.last.nil? || value.last == "")
	                status = "nil_field_#{str}"
	            end
	        end
		end

		status
	end

	def get_new(value, params)
		field = value.first.split('-')
		index_id = field.last.to_i
		field_name = field.first

		if !field_name.at("type").nil?
			fields = field_name.split('_')

			date_last = nil
			begin
				date_last = DateTime.parse(params[:worksheet_education]["date_last_#{fields.last}-#{index_id}"])
			rescue
			end

			WorksheetEducation.new(
				:type_education => params[:worksheet_education]["type_#{fields.last}-#{index_id}"],
				:name => params[:worksheet_education]["name_#{fields.last}-#{index_id}"],
				:date_last => date_last)
		end
	end
end