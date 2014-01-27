# coding: utf-8
class WorksheetController < ApplicationController
	def create
		status = "add"
		user_avatar = nil
		unless params[:user_avatar].nil?
			params[:user_avatar].each do |value|
				unless value.first.at("field").nil?
					if value.last.to_i > 0
						status = "user_avatar"
						user_avatar = params[:user_avatar]["photo-#{value.last.to_i}"]
					end
				end
			end
		end

		if status == "user_avatar" # сохраняем аватар и показываем его пользователю

			worksheet_field = WorksheetField.new()
			worksheet_field.save

			user_guest = User.new_guest

			attachment = Attachment.new
			attachment.file = user_avatar
			attachment.attachable = worksheet_field
			attachment.user = user_guest
			attachment.save

			render :json => { :status => status, :worksheet_field_id => worksheet_field.id, 
				:photo => attachment.original_filename }
		elsif status == "add"
		else
			render :json => { :status => "error" }
		end
	end
end