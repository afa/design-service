class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.orders.count > 0
        redirect_to controller: 'profiles', action: 'orders'
      else
        redirect_to controller: 'profiles', action: 'edit'
      end
    else
      render layout: false
    end
  end
end
