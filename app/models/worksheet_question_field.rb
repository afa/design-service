# coding: utf-8
class WorksheetQuestionField < ActiveRecord::Base
	belongs_to :worksheet, class_name: 'Worksheet', foreign_key: 'worksheet_id'
	belongs_to :question_field
	belongs_to :question
	
	has_one :attachment, as: :attachable, class_name: 'Attachment', dependent: :destroy

	def get_status_necessarily(value, params)
		status = "success"
		is_field = true
		field = value.first.split('-')
		index_id = field.last.to_i
		field_name = field.first

		value_level = nil
		value_description = nil
		attach = nil

		if !field_name.at("experience_name").nil?
			worksheet_experience = WorksheetExperience.new
			worksheet_experience.get_status_necessarily(value, params)
		elsif !field_name.at("description_work").nil? # описание и файл
			value_data = value.last
			fields = field_name.split('_')

			question_field = nil

			begin
	        	question_field = QuestionField.find(index_id)
	        rescue
	            status = "error_field"
	        end
	        field_data = Question.find(question_field.question_id)

	        if field_data.is_necessarily
				unless fields.nil?
					attach = params[:question_field]["file_work_#{fields.last}-#{index_id}"]
					status = "file_work_nil" if attach.nil?
				else
					status = "file_work_nil"
				end

				if value_data == "" || value_data.nil?
					status = "description_work_nil"
				end
			end
		elsif !field_name.at("value").nil?
			value_data = value.last
			question_field_id = nil
			question_id = index_id
			field_data = nil

			begin
	        	field_data = Question.find(index_id)
	        rescue
	            status = "error_field"
	        end

	        unless field_data.nil?
	            if field_data.is_necessarily && (value_data.nil? || value_data == "")
	                status = "nil_field_value"
	            end
	        end
		else
			question_id = nil
			value_data = value.last
			question_field_id = index_id

			question_field = nil

			begin
	        	question_field = QuestionField.find(index_id)
	        rescue
	            status = "error_field"
	        end

	        unless question_field.nil?
	        	field_data = Question.find(question_field.question_id)
	            if field_data.is_necessarily && (value_data.nil? || value_data == "")
	                status = "nil_field_#{field_name}"
	            end
	        end
		end

		status
	end

	def get_new_attachment(value, params)
		field = value.first.split('-')
		index_id = field.last.to_i
		field_name = field.first

		value_level = nil
		value_description = nil

		value_data = value.last
		fields = field_name.split('_')

		unless fields.nil?
			file = params[:question_field]["file_work_#{fields.last}-#{index_id}"]
			unless file.nil?
				attachment = Attachment.new
				attachment.file = file
				attachment.attachable = WorksheetQuestionField.last
				attachment.user = User.new_guest
				attachment.save
			end
		end
	end

	def get_new_description_for_attachment(value, params)
		field = value.first.split('-')
		index_id = field.last.to_i
		field_name = field.first

		value_level = nil
		value_description = nil

		value_data = value.last
		fields = field_name.split('_')

		WorksheetQuestionField.new(
			:question_field_id => question_field_id,
			:value => value_data, 
			:question_id => question_id,
			:value_level => value_level,
			:value_description => value_description
		)
	end

	def get_new(value, params)
		field = value.first.split('-')
		index_id = field.last.to_i
		field_name = field.first

		value_level = nil
		value_description = nil

		if !field_name.at("description_work").nil? # описание и файл
			value_data = value.last
			fields = field_name.split('_')

			unless fields.nil?
				file = params[:question_field]["file_work_#{fields.last}-#{index_id}"]
				unless file.nil?
					attachment = Attachment.new
					attachment.file = file
					attachment.attachable = WorksheetQuestionField.last
					attachment.user = User.new_guest
					attachment.save
				end
			end
		elsif !field_name.at("value").nil?
			value_data = value.last
			question_field_id = nil
			question_id = index_id
		elsif !field_name.at("check").nil?
			value_data = value.last
			question_id = field.last
			if !field_name.at("check_level").nil?
				value_level = "true" 
			elsif !field_name.at("check_description").nil?
				value_description = "true"
			end
			question_field_id = field.last(2).first
		elsif !field_name.at("photo").nil?
			question_field_id = nil
			value_data = value.last
			question_id = index_id
		else
			question_id = nil
			value_data = value.last
			question_field_id = index_id
		end

		WorksheetQuestionField.new(
			:question_field_id => question_field_id,
			:value => value_data, 
			:question_id => question_id,
			:value_level => value_level,
			:value_description => value_description
		)
	end
end
