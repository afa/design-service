# coding: utf-8
class Adm::SpecialistGroupController < Adm::ApplicationController
	def get_by_specialist
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			specialization_id = params[:specialist_group_id].to_i
			groups = SpecialistGroup.where("specialization_id = ?", specialization_id)

			data = render_to_string(partial: 'adm/order/groups',
	            locals: {groups: groups
	                    },
	            layout: false, formats: [:html], handlers: [:haml])

			render :json => { data: data }
		else
			redirect_to root_path
		end
	end
end
