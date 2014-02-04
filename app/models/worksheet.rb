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

	# простые вопросы по полям
	def get_worksheet_questions
		self.worksheet_question_fields.select("question_field_id")\
			.group("question_field_id")\
			.where("question_field_id is not null and question_id is null")
	end

	# вопросы по вопросу
	def get_questions_on_question
		self.worksheet_question_fields.select("question_id")\
			.group("question_id")\
			.where("question_id is not null")
	end

	# вопросы 'тесты с картинками'
	def get_questions_on_question_test_photo
		questions = Array.new

		self.worksheet_question_fields.where("question_id is not null").each do |value|
			unless value.question.nil?
				if value.question.kind == 'photo_test'
					questions << value
				end
			end
		end

		questions
	end

	# вопросы 'выбор чекбоксов'
	def get_questions_on_question_check_need
		questions = Array.new

		self.worksheet_question_fields.where("question_id is not null").each do |value|
			unless value.question.nil?
				if value.question.kind == 'check_need'
					questions << value
				end
			end
		end

		questions
	end

	# вопросы 'без выбора правильных'
	def get_questions_on_question_check_need
		questions = Array.new

		self.worksheet_question_fields.where("question_id is not null").each do |value|
			unless value.question.nil?
				if value.question.kind == 'check_need'
					questions << value
				end
			end
		end

		questions
	end

	def get_questions_from_test_photo
		self.questionnaire.questions.where("kind = 'photo_test'")
	end

	def get_rating_from_test_photo
		rating = 0

		self.get_questions_from_test_photo.each do |question|
			self.get_questions_on_question_test_photo.each do |field|
				if field.value.to_i == question.get_status_true_answer.id
					rating += 1
				end

				if field.value.to_i == question.get_status_false_answer.id
					rating -= 1
				end
			end
		end

		rating
	end

	def get_calc_rating
		calc_rating = 0

		rating_from_test_photo = self.get_rating_from_test_photo
		if rating_from_test_photo > -2
			if rating_from_test_photo == -1
				calc_rating += 3
			elsif rating_from_test_photo > -1 && rating_from_test_photo < 3
				calc_rating += 5
			else
				calc_rating += 10
			end

			self.get_questions_on_question_check_need.each do |value|
				if value.value_level == "true"
					if value.value.to_i == 4
						calc_rating += 1
					elsif value.value.to_i == 5
						calc_rating += 2
					end
				end
			end

			status_empty = false
			self.worksheet_question_fields.each do |value|
				if value.value == ""
					status_empty = true
				end
			end

			self.worksheet_fields.each do |value|
				if value.value == ""
					status_empty = true
				end
			end

			self.worksheet_experiences.each do |value|
				if value.name == ""
					status_empty = true
				end
			end

			self.worksheet_educations.each do |value|
				if value.name == ""
					status_empty = true
				end
			end

			if status_empty
				calc_rating -= 2
			else
				calc_rating += 2
			end
		end

		calc_rating
	end
end