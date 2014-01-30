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

	# чекбокс, который просто выбирают
	def check_select(args)
		@data = args[:data]

		render
	end

	# чекбокс, который просто выбирают. Для админки.
	def check_select_admin(args)
		@data = args[:data]
		
		render
	end

	# чекбокс, который выбирают и записывают значение
	def check_value(args)
		@data = args[:data]

		render
	end

	# чекбокс, который выбирают и записывают значение. Для админки.
	def check_value_admin(args)
		@data = args[:data]
		
		render
	end

	# да, нет
	def yes_no(args)
		@data = args[:data]

		render
	end

	# да, нет. Для админки.
	def yes_no_admin(args)
		@data = args[:data]
		
		render
	end

	# Описание с файлом
	def description_with_file(args)
		@data = args[:data]
		@index = args[:index]

		render
	end

	# Описание с файлом. Для админки.
	def description_with_file_admin(args)
		@data = args[:data]
		
		render
	end

	# минимальное количество полей
	def experience_min(args)
		@data = args[:data]

		render
	end

	# минимальное количество полей. Для админки.
	def experience_min_admin(args)
		@data = args[:data]
		
		render
	end

	# максимальное количество полей
	def experience_max(args)
		@data = args[:data]

		render
	end

	# максимальное количество полей. Для админки.
	def experience_max_admin(args)
		@data = args[:data]
		
		render
	end

	# значение во всю ширину
	def value(args)
		@data = args[:data]
		@index = args[:index]
		
		render
	end

	# значение во всю ширину. Для админки.
	def value_admin(args)
		@data = args[:data]
		
		render
	end

	# чекбокс для выбора без оценки
	def check_select_no_level(args)
		@data = args[:data]
		
		render
	end

	# чекбокс для выбора без оценки. Для админки.
	def check_select_no_level_admin(args)
		@data = args[:data]
		
		render
	end
end