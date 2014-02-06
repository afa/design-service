# coding: utf-8
class Adm::QuestionFieldController < Adm::ApplicationController
	def add_photo_test
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question_field = QuestionField.find(params[:id].to_i)

			attachment = Attachment.new
			attachment.file = params[:question_field][:photo]
			attachment.attachable = question_field
			attachment.user = User.current
			attachment.save

			render :json => {status: params[:question_field][:photo].inspect}
		end
	end

	def set_name
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question_field = QuestionField.find(params[:id].to_i)
			question_field.update_attributes(:name => params[:name])

			render :json => {status: ""}
		end
	end

	def destroy
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question_field = QuestionField.find(params[:id].to_i)
			question_field.destroy

			render :json => {status: ""}
		end
	end

	def set_statis_is_true
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question_field = QuestionField.find(params[:id].to_i)
			status = question_field.set_statis_is_true(params[:statis_is_true] == "true")

			render :json => {status: status}
		end
	end

	def set_status_is_false
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question_field = QuestionField.find(params[:id].to_i)
			status = question_field.set_status_is_false(params[:status_is_false] == "true")

			render :json => {status: status}
		end
	end
end
