# coding: utf-8
class Adm::GroupsController < Adm::ApplicationController
	include Adm::ApplicationHelper

	def index
		@page = params[:page].to_i
		@page = 1 if @page < 1

		@filter = "update_date_desc"
		@filter = params[:filter] unless params[:filter].nil?

		groups = SpecialistGroup.new
		@count_groups = groups.count_groups(@filter)
		get_pages_params(@page, SpecialistGroup.per_page, @count_groups) # берем данные об остальных страницах

		# берем пачку заказов, взятых по определенному фильтру
		@groups = groups.get_bunch_on_filter(@page, @filter)
	end
end
