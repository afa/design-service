class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def page_subtitle
    result = I18n.t :"controller_titles.#{params[:controller]}.#{params[:action]}",  default: [:"controller_titles.#{params[:controller]}"]
    result.is_a?(String) ? result : "#{self.class.name.underscore}##{params[:action]}"
  end
  def page_subtitle_class
    I18n.t :"controller_title_classes.#{params[:controller]}",  default: ''
  end
  helper_method :page_subtitle, :page_subtitle_class
  protected :page_subtitle, :page_subtitle_class

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password) }
  end
  protected :configure_permitted_parameters

  def current_ability
    @current_ability ||= Ability.new(current_or_guest_user)
  end

  # Should skip forgery protection for ajax requests (see https://github.com/plataformatec/devise/wiki/How-To:-Create-a-guest-user)
  #skip_before_filter :verify_authenticity_token, :only => [:name_of_your_ajax_action]

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
    guest_orders = guest_user.try{|user| user.orders.all}
    guest_orders.each do |order|
      order.client_id = current_user.id
      order.save!
    end
  end
end