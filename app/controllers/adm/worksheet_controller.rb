# coding: utf-8
class Adm::WorksheetController < Adm::ApplicationController
	include Adm::ApplicationHelper

	def index
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@page = params[:page].to_i
			@page = 1 if @page < 1

			@filter = "update_date_desc"
			@filter = params[:filter] unless params[:filter].nil?

			worksheet = Worksheet.new
			@count_groups = worksheet.count_groups(@filter)
			get_pages_params(@page, Worksheet.per_page, @count_groups) # берем данные об остальных страницах

			# берем пачку заказов, взятых по определенному фильтру
			@worksheets = worksheet.get_bunch_on_filter(@page, @filter)
			@user_data = get_current_user
		else
			redirect_to root_path
		end
	end

	def show
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@user_data = get_current_user
			@worksheet_data = Worksheet.find(params[:id].to_i)
		else
			redirect_to root_path
		end
	end
end