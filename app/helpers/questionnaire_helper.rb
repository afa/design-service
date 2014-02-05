module QuestionnaireHelper
	def number_question(i, is_numeric)
		@index_question += 1
		if is_numeric
			"#{i}" + '.'
		else
			""
		end
	end
end
