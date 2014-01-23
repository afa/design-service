# coding: utf-8
class Adm::QuestionnaireFieldsQuestionnaireController < Adm::ApplicationController
	
	def set_field
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			data = QuestionnaireFieldsQuestionnaire.find(params[:questionnaire_fields_questionnaire_id].to_i)
			data.update_attributes(:position => params[:position].to_i, 
				:location => params[:location], 
				:is_necessarily => params[:is_necessarily] == "true",
				:value => params[:value])

			render :json => {text: "Данные успешно сохранены"}
		end
	end

	def destroy
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?	
			data = QuestionnaireFieldsQuestionnaire.find(params[:id].to_i)
			data.destroy

			render :json => {text: "Данные удалены"}
		end
	end
end
