# coding: utf-8
class Adm::OrdersController < Adm::ApplicationController
	include Adm::ApplicationHelper

	# страница заказов
	def index
		@page = params[:page].to_i
		@page = 1 if @page < 1

		@filter = "update_date_desc"
		@filter = params[:filter] unless params[:filter].nil?

		order = Order.new
		@count_orders = order.count_orders(@filter)
		get_pages_params(@page, Order.per_page, @count_orders) # берем данные об остальных страницах

		# берем пачку заказов, взятых по определенному фильтру
		order = Order.new
		@orders = order.get_bunch_on_filter(@page, @filter)
	end
end
