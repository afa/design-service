class ApplicationController < ActionController::Base
  protect_from_forgery

  # Should skip forgery protection for ajax requests (see https://github.com/plataformatec/devise/wiki/How-To:-Create-a-guest-user)
  #skip_before_filter :verify_authenticity_token, :only => [:name_of_your_ajax_action]

#  helper_method :title, :subtitle

 layout :choose_layout

  private

  def choose_layout
    user_signed_in? ? "registered_layout" : "unregistered_layout"
  end

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end
  helper_method :current_or_guest_user

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= User.new_guest.id)
  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user
  end

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    guest_orders = guest_user.orders.all
    guest_orders.each do |order|
      order.user_id = current_user.id
      order.save!
    end
  end
end