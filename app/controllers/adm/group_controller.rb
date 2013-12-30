# coding: utf-8
class Adm::GroupController < Adm::ApplicationController
	def show
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@id = params[:id].to_i

			@group_data = SpecialistGroup.find(@id)
			@groups = Array.new
			@groups << @group_data

			@specialists = @group_data.specialists
			@user_data = get_current_user
		else
			redirect_to root_path
		end
	end

	def show_orders
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			@id = params[:id].to_i

			@group_data = SpecialistGroup.find(@id)
			@groups = Array.new
			@groups << @group_data

			@specialists = @group_data.specialists
			@orders = Order.where("specialist_group_id = ?", @id)
			@user_data = get_current_user
		else
			redirect_to root_path
		end
	end
end
