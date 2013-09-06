class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_root_path
      elsif current_user.orders.count > 0 || current_user.specialist?
        redirect_to controller: 'profiles', action: 'orders'
      else
        render 'layouts/welcome_page/registered', layout: false
      end
    else
      render 'layouts/welcome_page/unregistered', layout: false
    end
  end
end
