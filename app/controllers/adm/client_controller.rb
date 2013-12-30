# coding: utf-8
class Adm::ClientController < Adm::ApplicationController
	respond_to :html, :js, :xml

	def show
		@id = params[:id].to_i
		client = User.new

		@client_data = User.find(@id)
		# берем пачку заказов, взятых по определенному фильтру
		@clients = Array.new
		@clients << @client_data

		@orders = Order.where("executor_id = ? and executor_type = 'Specialist'", @id)
	end

	def new
	end

	#ActiveRecord::RecordInvalid - Возникли ошибки: Username translation missing: 
	#ru.activerecord.errors.models.user.attributes.username.immutable:
	def set_client
		#logger.debug "----------111-----------"
		id = params[:id].to_i
		user = User.find(id)

		user.update_attributes(:email => params[:email])

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

	def set_password
		id = params[:id].to_i
		user = User.find(id)
		user.password = params[:password]
		status = "success"

		if user.save
			message = "Пароль успешно сохранен"
		else
			status = "error"
			message = "Пароль должен содержать минимум 8 символов"
		end

		render :json => {status: status, message: message}
	end

	def autorization
		
	end
end
