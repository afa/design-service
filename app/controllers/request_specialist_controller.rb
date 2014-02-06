# coding: utf-8
class RequestSpecialistController < ApplicationController
	def set_status
		if User.current.specialist?
			request_specialist = RequestSpecialist.find(params[:id].to_i)
			request_specialist.update_attribute(:status, params[:status] == "true")

			request = render_to_string(partial: 'specialist_groups/specialist/request_specialist',
                    locals: {request: request_specialist},
                    layout: false, formats: [:html], handlers: [:haml])

			render :json => { :request => request }
		end
	end
end
