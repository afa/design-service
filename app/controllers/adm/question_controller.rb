# coding: utf-8
class Adm::QuestionController < ApplicationController
	def update
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question = Question.find(params[:id].to_i)
			question.update_attributes(:name => params[:name], :count_all => params[:count_all],
				:count_true => params[:count_true], :position => params[:position], :value => params[:value])

			render :json => {status: ""}
		end
	end

	def add_field
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question = Question.find(params[:question_id].to_i)
			question.add_field(params[:display])

			render :json => {status: ""}
		end
	end

	def create
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question = Question.new(:kind => params[:kind], :questionnaire_id => params[:questionnaire_id].to_i)
			question.add_default

			render :json => {status: ""}
		end
	end

	def destroy
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			question = Question.find(params[:id].to_i)
			question.destroy

			render :json => {status: ""}
		end
	end
end