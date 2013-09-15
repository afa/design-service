class ProfilesController < InheritedResources::Base
  defaults singleton: true
  before_filter :authenticate_user!
  respond_to :json

  ## This code can't work in this controller, but it should be moved to nested orders controller
  ## (and #orders action will be simplified to a default method, especially if N+1 problem will be solved)
  # has_scope :in_work, :type => :boolean, only: [:orders]
  # has_scope :not_in_work, :type => :boolean, only: [:orders]

  def orders
    orders = current_user.orders.includes(:orderable)
    if params[:in_work]
      @orderable = orders.in_work.decorate
    elsif params[:not_in_work]
      @orderable = orders.not_in_work.decorate
    else
      @orderable = orders.decorate
    end
  end
protected
  def begin_of_association_chain
    current_user
  end

  def permitted_params
    params.permit(profile: [:name, :surname, :middle_name])
  end

  def header
    if User.current.specialist? && params[:action] == 'edit'
      resource.to_s
    else
      super
    end
  end
end
