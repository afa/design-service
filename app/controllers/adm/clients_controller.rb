# coding: utf-8
class Adm::ClientsController < Adm::ApplicationController
	include Adm::ApplicationHelper

	def index
		@page = params[:page].to_i
		@page = 1 if @page < 1

		@filter = "update_date_desc"
		@filter = params[:filter] unless params[:filter].nil?

		client = User.new
		@count_clients = client.count_clients(@filter)
		get_pages_params(@page, User.per_page, @count_clients) # берем данные об остальных страницах

		# берем пачку заказов, взятых по определенному фильтру
		@clients = client.get_bunch_on_filter(@page, @filter)
	end
end
