# coding: utf-8
class Adm::SpecialistController < Adm::ApplicationController
	def get_by_group_and_specialization
		group_id = params[:group_id].to_i
		specialization_id = params[:specialization_id].to_i

		specialists = Specialist.joins("inner join specialist_groups_specialists on specialist_groups_specialists.specialist_id = specialists.id")\
			.where("specialists.specialization_id = ? and specialist_groups_specialists.specialist_group_id = ?", 
				specialization_id, group_id)

		logger.debug "-------------------#{group_id}-----#{specialization_id}---------------"

		data = render_to_string(partial: 'adm/order/specialists',
            locals: {specialists: specialists
                    },
            layout: false, formats: [:html], handlers: [:haml])

		render :json => { data: data }
	end

	def get_price
		specialist_id = params[:specialist_id].to_i
		order_id = params[:order_id].to_i

		specialist = Specialist.find(specialist_id)
		order = Order.find(order_id)

		render :json => { data: order.money_for_specialist_calc(specialist) }
	end
end