# coding: utf-8
class Adm::SpecialistGroupController < Adm::ApplicationController
	def get_by_specialist
		specialization_id = params[:specialist_group_id].to_i
		groups = SpecialistGroup.where("specialization_id = ?", specialization_id)

		data = render_to_string(partial: 'adm/order/groups',
            locals: {groups: groups
                    },
            layout: false, formats: [:html], handlers: [:haml])

		render :json => { data: data }
	end
end
