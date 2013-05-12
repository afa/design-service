class ProfileController < ApplicationController
  before_filter :authenticate_user!
  
  def edit
  end

  def specialists
    @specialists = current_user.liked_specialists.decorate
  end

  def orders
  end
end
