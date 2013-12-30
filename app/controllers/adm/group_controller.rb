# coding: utf-8
class Adm::GroupController < Adm::ApplicationController
	def show
		@id = params[:id].to_i

		@group_data = SpecialistGroup.find(@id)
		@groups = Array.new
		@groups << @group_data

		@specialists = @group_data.specialists
	end

	def show_orders
		@id = params[:id].to_i

		@group_data = SpecialistGroup.find(@id)
		@groups = Array.new
		@groups << @group_data

		@specialists = @group_data.specialists
		@orders = Order.where("specialist_group_id = ?", @id)
	end
end
