# coding: utf-8
class Adm::ClientController < Adm::ApplicationController
	def set_client
		client_id = params[:client_id].to_i
		user = User.find(client_id)
		user.update_attributes(params[:user])

		respond_to do |format|
			format.html
			format.js
		end
	end
end
