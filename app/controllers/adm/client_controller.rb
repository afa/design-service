# coding: utf-8
class Adm::ClientController < Adm::ApplicationController
	respond_to :html, :js, :xml

	def show
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@id = params[:id].to_i
			client = User.new

			@client_data = User.find(@id)
			# берем пачку заказов, взятых по определенному фильтру
			@clients = Array.new
			@clients << @client_data

			@orders = Order.where("executor_id = ? and executor_type = 'Specialist'", @id)
			@user_data = get_current_user
		else
			redirect_to root_path
		end
	end

	def new
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@user_data = get_current_user

		else
			redirect_to root_path
		end
	end

	def add
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			user = User.new(:username => params[:login], :password => params[:password],
				:email => params[:email])
			user.profile = Profile.new(:name => params[:name], :surname => params[:surname],
				:phone => params[:phone])
			status = user.save!

			if status
				render :json => {status: "true", id: User.last.id}
			else
				render :json => {status: "false"}
			end
		else
			redirect_to root_path
		end
	end

	#ActiveRecord::RecordInvalid - Возникли ошибки: Username translation missing: 
	#ru.activerecord.errors.models.user.attributes.username.immutable:
	def set_client
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			id = params[:id].to_i
			user = User.find(id)

			user.update_attributes(:email => params[:email])

			user.profile.update_attributes(:name => params[:name], :surname => params[:surname], 
				:phone => params[:phone])

			render :json => {status: ""}
		else
			redirect_to root_path
		end
	end

	def del
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			id = params[:id].to_i
			user = User.find(id)
			user.destroy

			render :json => {status: ""}
		else
			redirect_to root_path
		end
	end

	def set_password
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
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
		else
			redirect_to root_path
		end
	end

	def autorization

	end
end