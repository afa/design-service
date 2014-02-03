# coding: utf-8
class Worksheet < ActiveRecord::Base
	self.per_page = 20

	has_many :worksheet_fields
	has_many :worksheet_experiences
	has_many :worksheet_educations
	has_many :worksheet_question_fields

	belongs_to :questionnaire

	# возможно нужно будет переделать с учетом переделываний формы для вьюхи
	# оставить для разбора 
	def add(params)
		status = "success"
		worksheet_field = WorksheetField.new
		worksheet_education = WorksheetEducation.new
		worksheet_question_field = WorksheetQuestionField.new
		worksheet_experience = WorksheetExperience.new

		unless params[:questionnaire_field].nil?
			params[:questionnaire_field].each do |value|
				status = worksheet_field.get_status_necessarily(value)
				break if status != "success"
			end
		end

		unless params[:worksheet_education].nil?
			params[:worksheet_education].each do |value|
				status = worksheet_education.get_status_necessarily(value)
				break if status != "success"
			end
		end

		unless params[:question_field].nil?
			params[:question_field].each do |value|
				status = worksheet_question_field.get_status_necessarily(value, params)
				break if status != "success"
			end
		end

		# если статус в порядке, анкета сохраняется
		if status == "success"
			save

			unless params[:questionnaire_field].nil?
				params[:questionnaire_field].each do |value|
					worksheet_field_new = worksheet_field.get_new(value)
					self.worksheet_fields << worksheet_field_new unless worksheet_field_new.nil?
					self.save
				end
			end

			unless params[:worksheet_education].nil?
				params[:worksheet_education].each do |value|
					worksheet_education_new = worksheet_education.get_new(value, params)
					self.worksheet_educations << worksheet_education_new unless worksheet_education_new.nil?
					self.save
				end
			end

			unless params[:question_field].nil?
				params[:question_field].each do |value|
					field = value.first.split('-')
					index_id = field.last.to_i
					field_name = field.first

					if !field_name.at("experience_name").nil?
						worksheet_experience_new = worksheet_experience.get_new(value, params)
						self.worksheet_experiences << worksheet_experience_new unless worksheet_experience_new.nil?
						self.save
					elsif !field_name.at("description_work").nil?
						worksheet_question_field_new = worksheet_question_field.get_new_description_for_attachment(value, params)
						self.worksheet_question_fields << worksheet_question_field_new unless worksheet_question_field_new.nil?
						self.save
						worksheet_question_field.get_new_attachment(value, params)
					else
						if field_name.at("experience_description").nil? && field_name.at("experience_date_start").nil? && field_name.at("experience_date_end").nil? &&
								field_name.at("experience_city").nil? && field_name.at("experience_country").nil? && field_name.at("experience_region").nil? &&
								field_name.at("experience_position").nil? && field_name.at("file_work").nil? && field_name.at("description_work").nil?
							worksheet_question_field_new = worksheet_question_field.get_new(value, params)
							#p "----------"
							#p worksheet_question_field_new.inspect
							self.worksheet_question_fields << worksheet_question_field_new unless worksheet_question_field_new.nil?
							self.save
						end
					end
				end
			end
		end

		status
	end

	def get_bunch_on_filter(page, filter)
		Worksheet.paginate(:page => page).order("created_at desc")
	end

	def count_groups(filter)
		Worksheet.count
	end

	def get_worksheet_questions
		self.worksheet_question_fields.select("question_field_id").group("question_field_id").where("question_field_id is not null")
	end
end
