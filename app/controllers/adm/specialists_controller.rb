# coding: utf-8
class Adm::SpecialistsController < Adm::ApplicationController
	include Adm::ApplicationHelper

	# страница заказов
	def index
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@page = params[:page].to_i
			@page = 1 if @page < 1

			@filter = "update_date_desc"
			@filter = params[:filter] unless params[:filter].nil?

			specialist = Specialist.new
			@count_specialists = specialist.count_specialists(@filter)
			get_pages_params(@page, Specialist.per_page, @count_specialists) # берем данные об остальных страницах

			# берем пачку заказов, взятых по определенному фильтру
			@specialists = specialist.get_bunch_on_filter(@page, @filter)
			@user_data = get_current_user
		else
			redirect_to root_path
		end
	end

	def get_by_specialization
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			specialization_id = params[:specialization_id].to_i

			specialists = Specialist\
				.where("specialists.specialization_id = ?", 
					specialization_id)

			data = render_to_string(partial: 'adm/group/specialists',
	            locals: {specialists: specialists
	                    },
	            layout: false, formats: [:html], handlers: [:haml])

			render :json => { data: data }
		else
			redirect_to root_path
		end
	end
end
