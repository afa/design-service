# coding: utf-8
class QuestionCell < Cell::Rails
	# вопрос для теста из фотографий
	def photo_test(args)
		@data = args[:data]
		@index_question = args[:index_question]

		render
	end

	# вопрос для теста из фотографий. Для админки.
	def photo_test_admin(args)
		@data = args[:data]
		
		render
	end

	# вопрос для теста из фотографий. Для админки.
	def photo_test_admin_show(args)
		@data = args[:data]
		@question_data = @data.question_field.question
		
		render
	end

	# вопрос для отображения 1 рандомного вопроса из списка возможных
	def random_question(args)
		@data = args[:data]
		@index_question = args[:index_question]

		render
	end

	# вопрос для отображения 1 рандомного вопроса из списка возможных. Для админки.
	def random_question_admin(args)
		@data = args[:data]
		
		render
	end

	# вопрос для отображения 1 рандомного вопроса из списка возможных. Для админки.
	def random_question_admin_show(args)
		@data = args[:data]
		@question_data = @data.question_field.question
		@id = args[:id].to_i
		@data_field = WorksheetQuestionField.where("question_field_id = ? and worksheet_id = ?", @data.question_field_id, @id).first
		
		render
	end

	# вопрос, в котором нужно отметить желаемые варианты
	def check_need(args)
		@data = args[:data]
		@index_question = args[:index_question]

		render
	end

	# вопрос, в котором нужно отметить желаемые варианты. Для админки.
	def check_need_admin(args)
		@data = args[:data]
		
		render
	end

	# вопрос, в котором нужно отметить желаемые варианты. Для админки.
	def check_need_admin_show(args)
		@data = args[:data]
		@question_data = @data.question
		@id = args[:id].to_i
		@data_fields = WorksheetQuestionField.where("question_id = ? and worksheet_id = ?", @data.question_id, @id)
		
		render
	end

	# вопрос "да-нет"
	def yes_no(args)
		@data = args[:data]
		@index_question = args[:index_question]

		render
	end

	# вопрос "да-нет". Для админки.
	def yes_no_admin(args)
		@data = args[:data]
		
		render
	end

	# вопрос "да-нет". Для админки.
	def yes_no_admin_show(args)
		@data = args[:data]
		@question_data = @data.question_field.question
		@id = args[:id].to_i
		@data_field = WorksheetQuestionField.where("question_field_id = ? and worksheet_id = ?", @data.question_field_id, @id).first
		
		render
	end

	# вопрос для прикрепления файлов с описанием
	def add_files(args)
		@data = args[:data]
		@index_question = args[:index_question]
		@index = 0

		render
	end

	# вопрос для прикрепления файлов с описанием. Для админки.
	def add_files_admin(args)
		@data = args[:data]
		
		render
	end

	# вопрос для прикрепления файлов с описанием. Для админки.
	def add_files_admin_show(args)
		@data = args[:data]
		
		render
	end

	# опыт работы с минимальным количеством полей
	def experience_min(args)
		@data = args[:data]
		@index_question = args[:index_question]

		render
	end

	# опыт работы с минимальным количеством полей. Для админки.
	def experience_min_admin(args)
		@data = args[:data]
		
		render
	end

	# опыт работы с минимальным количеством полей. Для админки.
	def experience_min_admin_show(args)
		@data = args[:data]
		
		render
	end

	# опыт работы с максимальным количеством полей
	def experience_max(args)
		@data = args[:data]
		@index_question = args[:index_question]

		render
	end

	# опыт работы с максимальным количеством полей. Для админки.
	def experience_max_admin(args)
		@data = args[:data]
		
		render
	end

	# опыт работы с максимальным количеством полей. Для админки.
	def experience_max_admin_show(args)
		@data = args[:data]
		
		render
	end

	# строки для описания с подгружаемыми по мере заполнения
	def add_values(args)
		@data = args[:data]
		@index_question = args[:index_question]
		@index = 1

		render
	end

	# строки для описания с подгружаемыми по мере заполнения. Для админки.
	def add_values_admin(args)
		@data = args[:data]
		
		render
	end

	# строки для описания с подгружаемыми по мере заполнения. Для админки.
	def add_values_admin_show(args)
		@data = args[:data]
		@question_data = @data.question
		@id = args[:id].to_i
		@data_fields = WorksheetQuestionField.where("question_id = ? and worksheet_id = ?", @data.question_id, @id)
		
		render
	end
end
