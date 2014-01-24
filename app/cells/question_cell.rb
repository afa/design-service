# coding: utf-8
class QuestionCell < Cell::Rails
	# вопрос для теста из фотографий
	def photo_test(args)
		@data = args[:data]

		render
	end

	# вопрос для теста из фотографий. Для админки.
	def photo_test_admin(args)
		@data = args[:data]
		
		render
	end

	# вопрос для отображения 1 рандомного вопроса из списка возможных
	def random_question(args)
		@data = args[:data]

		render
	end

	# вопрос для отображения 1 рандомного вопроса из списка возможных. Для админки.
	def random_question_admin(args)
		@data = args[:data]
		
		render
	end
end
