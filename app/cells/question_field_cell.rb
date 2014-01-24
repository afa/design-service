# coding: utf-8
class QuestionFieldCell < Cell::Rails

	# вопрос в виде теста из определенного количества фоток.
	def photo_test(args)
		@data = args[:data]

		render
	end

	# вопрос в виде теста из определенного количества фоток. Для админки.
	def photo_test_admin(args)
		@data = args[:data]
		@question_field = QuestionField.new
		
		render
	end

	# 1 из вопросов, который отображается для пользователя рандомно
	def question_for_random_question(args)
		@data = args[:data]

		render
	end

	# 1 из вопросов, который отображается для пользователя рандомно. Для админки.
	def question_for_random_question_admin(args)
		@data = args[:data]
		
		render
	end
end