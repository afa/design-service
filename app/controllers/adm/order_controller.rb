# coding: utf-8
class Adm::OrderController < Adm::ApplicationController
	def show
		id = params[:id]

		@order_data = Order.find(id)
		@orders = Array.new
		@orders << @order_data
	end
end
