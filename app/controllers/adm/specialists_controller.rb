# coding: utf-8
class Adm::SpecialistsController < Adm::ApplicationController
	include Adm::ApplicationHelper

	# страница заказов
	def index
		@page = params[:page].to_i
		@page = 1 if @page < 1

		@filter = "update_date_desc"
		@filter = params[:filter] unless params[:filter].nil?

		specialist = Specialist.new
		@count_specialists = specialist.count_specialists(@filter)
		get_pages_params(@page, Specialist.per_page, @count_specialists) # берем данные об остальных страницах

		# берем пачку заказов, взятых по определенному фильтру
		@specialists = specialist.get_bunch_on_filter(@page, @filter)
	end
end
