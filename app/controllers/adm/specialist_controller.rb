# coding: utf-8
class Adm::SpecialistController < Adm::ApplicationController
	def show
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@id = params[:id].to_i
			@specialist_data = Specialist.find(@id)

			# берем пачку заказов, взятых по определенному фильтру
			@specialists = Array.new
			@specialists << @specialist_data

			@orders = Order.where("executor_id = ? and executor_type = 'Specialist'", @id)
			@groups = SpecialistGroup\
	      		.joins("inner join specialist_groups_specialists on specialist_groups_specialists.specialist_group_id = specialist_groups.id")\
	      		.where("specialist_groups_specialists.specialist_id = ?", @id)

	      	portfolio_item = PortfolioItem.new
	      	@portfolios = Portfolio.where("specialist_id = ?", @id)
	      	@groups_all = SpecialistGroup.all
	      	@portfolio_items = portfolio_item.get_bunches(@portfolios)
	      	@user_data = get_current_user
      	else
			redirect_to root_path
		end
	end

	def new
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@user_data = get_current_user
			@specializations = Specialization.all
			@groups = SpecialistGroup.all
		else
			redirect_to root_path
		end
	end

	def add
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			user = User.new(:username => params[:login], :password => params[:password],
				:email => params[:email], :role => 'specialist')
			user.profile = Profile.new(:name => params[:name], :surname => params[:surname],
				:phone => params[:phone])
			status = user.save!

			specialist = Specialist.new
			specialist.user = User.last
			specialist.specialist_groups << SpecialistGroup.find(params[:group_id].to_i)
			specialist.specialization_id = params[:specialization_id].to_i
			specialist.save!

			if status
				render :json => {status: "true", id: Specialist.last.id}
			else
				render :json => {status: "false"}
			end
		else
			redirect_to root_path
		end
	end

	def get_by_group_and_specialization
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
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
		else
			redirect_to root_path
		end
	end

	def get_price
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			specialist_id = params[:specialist_id].to_i
			order_id = params[:order_id].to_i

			specialist = Specialist.find(specialist_id)
			order = Order.find(order_id)

			render :json => { data: order.money_for_specialist_calc(specialist) }
		else
			redirect_to root_path
		end
	end

	def set
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			id = params[:id].to_i
			specialist = Specialist.find(id)

			specialist.user.profile.update_attributes(:surname => params[:surname], 
				:phone => params[:phone])

			specialist.user.update_attributes(:email => params[:email])

			render :json => {status: ""}
		else
			redirect_to root_path
		end
	end

	def del
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			id = params[:id].to_i
			user = Specialist.find(id)
			user.destroy

			render :json => {status: ""}
		else
			redirect_to root_path
		end
	end

	def add_to_group
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			group_id = params[:group_id].to_i
			specialist_id = params[:specialist_id].to_i

			specialist = Specialist.find(specialist_id)
			specialist.specialist_groups << SpecialistGroup.find(group_id)
			specialist.save

			render :json => {status: ""}
		else
			redirect_to root_path
		end
	end

	def del_from_group
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			group_id = params[:group_id].to_i
			specialist_id = params[:specialist_id].to_i

			specialist = Specialist.find(specialist_id)
			specialist.specialist_groups -= [SpecialistGroup.find(group_id)]
			specialist.save

			render :json => {status: ""}
		else
			redirect_to root_path
		end
	end

	def add_request_to_group
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			new_request = RequestSpecialist.new(:specialist_group_id => params[:group_id].to_i,
				:join_specialist_id => params[:specialist_id].to_i)
			new_request.add

			render :json => {status: ""}
		else
			redirect_to root_path
		end
	end

	def del_request
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			request = RequestSpecialist.find(params[:request_id].to_i)
			request.destroy

			render :json => {status: ""}
		else
			redirect_to root_path
		end
	end

	def set_specialization
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			specialist = Specialist.find(params[:id].to_i)
			specialist.update_attribute(:specialization_id, params[:specialization].to_i)

			render :json => {status: ""}
		end
	end
end
