class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_root_path
      elsif current_user.orders.count > 0
        redirect_to controller: 'profiles', action: 'orders'
      else
        render 'index_registered', layout: false
      end
    else
      render 'index_unregistered', layout: false
    end
  end
end
