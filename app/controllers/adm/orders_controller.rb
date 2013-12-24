# coding: utf-8
class Adm::OrdersController < Adm::ApplicationController

	# страница заказов
	def index
		@page = params[:page].to_i
		@page = 1 if @page < 1

		# берем пачку заказов, взятых по определенному фильтру
		@orders = Order.paginate(:page => @page)
	end
end
