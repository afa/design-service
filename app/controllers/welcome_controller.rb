class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to controller: 'profiles', action: 'show'
    else
      render layout: false
    end
  end
end
