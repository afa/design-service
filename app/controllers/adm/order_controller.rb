# coding: utf-8
class Adm::OrderController < Adm::ApplicationController
	def show
		@id = params[:id].to_i

		@order_data = Order.find(@id)
		@orders = Array.new
		@orders << @order_data
	end

	# назначаем специалиста и устонавливаем цены
	#Work state translation missing: ru.activerecord.errors.models.order.attributes.work_state.invalid_transition
	def set_specialist
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
			  logger.debug "-------------------#{order.errors.full_messages}----------------------"
			  @message = "Произошла ошибка при сохранении"
			end
		else
			@message = "Вы не выбрали специалиста"
		end

		respond_to do |format|
			format.html
			format.js
		end
	end
end
