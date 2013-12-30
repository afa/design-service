# coding: utf-8
class Adm::SpecialistController < Adm::ApplicationController
	def show
		@id = params[:id].to_i
		@specialist_data = Specialist.find(@id)

		# берем пачку заказов, взятых по определенному фильтру
		@specialists = Array.new
		@specialists << @specialist_data

		@orders = Order.where("client_id = ?", @id)
		@groups = SpecialistGroup\
      		.joins("inner join specialist_groups_specialists on specialist_groups_specialists.specialist_group_id = specialist_groups.id")\
      		.where("specialist_groups_specialists.specialist_id = ?", @id)

      	portfolio_item = PortfolioItem.new
      	@portfolios = Portfolio.where("specialist_id = ?", @id)
      	@groups_all = SpecialistGroup.all
      	@portfolio_items = portfolio_item.get_bunches(@portfolios)
	end

	def get_by_group_and_specialization
		group_id = params[:group_id].to_i
		specialization_id = params[:specialization_id].to_i

		specialists = Specialist.joins("inner join specialist_groups_specialists on specialist_groups_specialists.specialist_id = specialists.id")\
			.where("specialists.specialization_id = ? and specialist_groups_specialists.specialist_group_id = ?", 
				specialization_id, group_id)

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

	def set
		id = params[:id].to_i
		specialist = Specialist.find(id)

		specialist.user.profile.update_attributes(:surname => params[:surname], 
			:phone => params[:phone])

		specialist.user.update_attributes(:email => params[:email])

		render :json => {status: ""}
	end

	def del
		id = params[:id].to_i
		user = Specialist.find(id)
		user.destroy

		render :json => {status: ""}
	end

	def add_to_group
		group_id = params[:group_id].to_i
		specialist_id = params[:specialist_id].to_i

		specialist = Specialist.find(specialist_id)
		specialist.specialist_groups << SpecialistGroup.find(group_id)
		specialist.save

		render :json => {status: ""}
	end

	def del_from_group
		group_id = params[:group_id].to_i
		specialist_id = params[:specialist_id].to_i

		specialist = Specialist.find(specialist_id)
		specialist.specialist_groups -= [SpecialistGroup.find(group_id)]
		specialist.save

		render :json => {status: ""}
	end
end
