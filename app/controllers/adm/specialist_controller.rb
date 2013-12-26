# coding: utf-8
class Adm::SpecialistController < Adm::ApplicationController
	def get_by_group_and_specialization
		group_id = params[:specialist_id].to_i
		specialization_id = params[:specialization_id].to_i
		Specialist.specialist_groups.where("specialist_groups.specialization_id = ? and ", 
			specialization_id)
	end
end
