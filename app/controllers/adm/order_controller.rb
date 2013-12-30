# coding: utf-8
class Adm::OrderController < Adm::ApplicationController
	def show
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@id = params[:id].to_i

			@order_data = Order.find(@id)
			@orders = Array.new
			@orders << @order_data

			@messages = @order_data.messages
			@user_data = get_current_user

			@order_data.update_attribute(:review_admin, true) unless @order_data.review_admin

			#message = Message.new
			#message.attached_to = @order_data
			#message.text = "Новое сообщение"
			#message.sender = User.find(4)
			#message.recipient = User.find(1)
			#message.save
		else
			redirect_to root_path
		end
	end

	# назначаем специалиста и устонавливаем цены
	#Work state translation missing: ru.activerecord.errors.models.order.attributes.work_state.invalid_transition
	def set_specialist
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			executor_id = params[:order][:executor_id].to_i
			order_id = params[:order_id].to_i
			@status = false

			if executor_id > 0
				order = Order.find(order_id)
				#order.executor = Specialist.find(executor_id)
				order.executor_id = executor_id
				order.executor_type = "Specialist"

				begin
				  raise unless order.save!
				  @status = true
				  @message = "Специалист назначен"
				  order.update_attributes(:price => params[:order][:price], :specialist_price => params[:order][:specialist_price])
				rescue ActiveRecord::RecordNotSaved => e
				  #logger.debug "-------------------#{order.errors.full_messages}----------------------"
				  @message = "Произошла ошибка при сохранении"
				end
			else
				@message = "Вы не выбрали специалиста"
			end

			respond_to do |format|
				format.html
				format.js
			end
		else
			redirect_to root_path
		end
	end

	# нужно отправлять на почту, что пришло сообщение
	def send_message
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			sender_id = params[:sender_id].to_i
			type = params[:type]
			text = params[:text]
			id = params[:id].to_i

			message = Message.find(id)
			message.update_attribute(:text, text)

			render :json => {status: ""}
		else
			redirect_to root_path
		end
	end

	def check_new
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			

			render :json => {order_last_id: Order.last.id}
		else
			redirect_to root_path
		end
	end
end
