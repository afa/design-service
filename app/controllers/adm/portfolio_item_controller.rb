# coding: utf-8
class Adm::PortfolioItemController < Adm::ApplicationController
	def get_next
		if get_current_user.moderator? || get_current_user.main_moderator? || get_current_user.admin?
			page = params[:page].to_i
			portfolio_id = params[:portfolio_id].to_i

			portfolioItem = PortfolioItem.new
			@portfolio_items = Hash.new
			@portfolio_items[portfolio_id] = portfolioItem.get_bunch_on_filter(page, '', portfolio_id)

			items = render_to_string(partial: 'adm/specialist/portfolio_items',
	            locals: {value: Portfolio.find(portfolio_id, :select => "id")
	                    },
	            layout: false, formats: [:html], handlers: [:haml])

			render :json => { items: items }
		else
			redirect_to root_path
		end
	end
end
