# coding: utf-8
class Adm::QuestionnaireController < Adm::ApplicationController

	def index
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@user_data = get_current_user

			@questionnaires = Questionnaire.all

		else
			redirect_to root_path
		end
	end

	def show
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@user_data = get_current_user
		
			@id = params[:id].to_i
			@questionnaire_data = Questionnaire.find(@id)
			@specializations = Specialization.all

			
		else
			redirect_to root_path
		end
	end

	def set_headers
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			data = Questionnaire.find(params[:id].to_i)
			data.update_attributes(:name => params[:name], :specialization_id => params[:specialization_id])

			render :json => {status: ""}
		end
	end

	def add_field
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			questionnaire = Questionnaire.find(params[:id].to_i)
			questionnaire.add_field(params[:questionnaire_field_id].to_i)

			render :json => {status: ""}
		end
	end
end
