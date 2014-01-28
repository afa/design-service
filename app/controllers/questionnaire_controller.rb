# coding: utf-8
class QuestionnaireController < ApplicationController

	# показываем анкету для заполнения пользователю
	def show
		@questionnaire_data = Questionnaire.find(params[:id].to_i)
		@worksheet = Worksheet.new
		@index_question = 1

		@headers_left = @questionnaire_data.get_headers('left')
		@headers_right = @questionnaire_data.get_headers('right')
		@headers_center_full = @questionnaire_data.get_headers('center_full')

		@questions_photo_test = @questionnaire_data.get_questions('photo_test')
		@questions_other = @questionnaire_data.get_questions_other
	end
end
