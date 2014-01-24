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
end
