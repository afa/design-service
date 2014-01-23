# coding: utf-8
class Adm::QuestionController < ApplicationController
	def update
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question = Question.find(params[:id].to_i)
			question.update_attributes(:name => params[:name], :count_all => params[:count_all],
				:count_true => params[:count_true])

			render :json => {status: ""}
		end
	end
end