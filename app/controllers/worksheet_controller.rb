# coding: utf-8
class WorksheetController < ApplicationController
	def create
		status = "add"
		user_avatar = nil
		user_avatar_questionnaire_fields_questionnaire_id = 0
		unless params[:user_avatar].nil?
			params[:user_avatar].each do |value|
				unless value.first.at("field").nil?
					if value.last.to_i > 0
						status = "user_avatar"
						user_avatar = params[:user_avatar]["photo-#{value.last.to_i}"]
						user_avatar_questionnaire_fields_questionnaire_id = value.last.to_i
					end
				end
			end
		end

		if status == "user_avatar" # сохраняем аватар и показываем его пользователю
			worksheet_field = WorksheetField.new(:questionnaire_fields_questionnaire_id => user_avatar_questionnaire_fields_questionnaire_id)
			data = worksheet_field.add_avatar(user_avatar)
			render :json => data
		elsif status == "add"
			worksheet = Worksheet.new(:questionnaire_id => params[:questionnaire_id].to_i)
			#worksheet.add(params)

			render :json => { :status => "success" }
		else
			render :json => { :status => "error" }
		end
	end
end