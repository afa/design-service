# coding: utf-8
class Adm::ClientController < Adm::ApplicationController
	respond_to :html, :js, :xml

	def show

	end

	#ActiveRecord::RecordInvalid - Возникли ошибки: Username translation missing: 
	#ru.activerecord.errors.models.user.attributes.username.immutable:
	def set_client
		#logger.debug "----------111-----------"
		id = params[:id].to_i
		user = User.find(id)

		user.update_attributes(:username => params[:username], :email => params[:email])

		user.profile.update_attributes(:name => params[:name], :surname => params[:surname], 
			:phone => params[:phone])

		render :json => {status: ""}
	end

	def del
		id = params[:id].to_i
		user = User.find(id)
		user.destroy

		render :json => {status: ""}
	end
end
