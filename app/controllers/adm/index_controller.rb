# coding: utf-8
class Adm::IndexController < Adm::ApplicationController
	def index
		#user = User.find(135966)
		#user.password = "113355panchuk35"
		#user.save

		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			redirect_to "/adm/orders"
		else
			redirect_to root_path
		end
	end
end
