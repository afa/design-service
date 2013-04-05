class ApplicationController < ActionController::Base
  protect_from_forgery

#  helper_method :title, :subtitle

 layout :choose_layout

  private

  def choose_layout
    user_signed_in? ? "registered_layout" : "unregistered_layout"
  end
end
