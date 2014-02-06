class WelcomeController < ApplicationController
  def index
    unless params[:need_recov].blank?
     content_for :need_recov do
      render :partial => 'layouts/unregistered/registration_form2'  #!!!
     end
    end
    if user_signed_in?
      if current_user.admin? || current_user.moderator?
        redirect_to adm_orders_path
      elsif current_user.orders.count > 0 || current_user.try(:specialist?)
        redirect_to controller: 'profiles', action: 'orders'
      else
        render 'layouts/welcome_page/registered', layout: false
      end
    else
      render 'layouts/welcome_page/unregistered', layout: false
    end
  end

  def anketa1
    #user = User.find(135966)
    #user.password = "113355panchuk35"
    #user.save
  end

  def anketa2
    
  end

  def anketa3
    
  end

  def anketa4
    
  end

  def anketa5
    
  end
end
