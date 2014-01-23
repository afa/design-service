class QuestionFieldCell < Cell::Rails

	# вопрос в виде теста из определенного количества фоток.
	def photo_test(args)
		@data = args[:data]

		render
	end

	# вопрос в виде теста из определенного количества фоток. Для админки.
	def photo_test_admin(args)
		@data = args[:data]
		
		render
	end
end