class ProfilesController < InheritedResources::Base
  defaults singleton: true
  before_filter :authenticate_user!
  respond_to :json
  custom_actions :resource => [:set_avatar]

  before_filter do
    @profile = resource.decorate
  end

  ## This code can't work in this controller, but it should be moved to nested orders controller
  ## (and #orders action will be simplified to a default method, especially if N+1 problem will be solved)
  # has_scope :in_work, :type => :boolean, only: [:orders]
  # has_scope :not_in_work, :type => :boolean, only: [:orders]

  def orders
    if User.current.client?
      orders = User.current.orders.not_empty.includes(:orderable)
    elsif User.current.specialist?
      orders = User.current.specialist.orders.not_empty.includes(:orderable)
    end
    if params[:in_work]
      @orderable = orders.in_work.decorate
    elsif params[:not_in_work]
      @orderable = orders.not_in_work.decorate
    else
      @orderable = orders.decorate
    end
  end
  def new_orders

    if User.current.client?
      @orderable = User.current.orders.includes(:orderable).not_in_work.decorate
    elsif User.current.specialist?
      @orderable = User.current.specialist.orders.includes(:orderable).not_in_work.decorate
    end

  end

  def set_avatar
    user = resource.user
    user.avatar = params[:avatar]
    user.save!
    respond_with(resource)
  end

  def add_portfolio
    specialist = resource.specialist
    specialist.portfolios.create
    respond_with(resource)
  end

  def give_money
   order = Order.find_by_id(params[:order])
   amount = params[:many].to_f
   if amount > 0.0 && amount <= curent_user.qiwi
    if User.current.give(order, amount)
     redirect_to :back, :flash => {:message => "Деньги переведены"}
    else
     redirect_to :back, :flash => {:error => "Попробуйте еще раз"}
    end
   end
  end
  def profile1
   @orders = User.current.orders.where(:work_state => %w(sent_to_moderator moderator_suggested specialist_agreed specialist_disagreed client_agreed in_work))
   render :json => {:to_whom => 'client', :data => render_to_string("profiles/profile1.html.haml", :layout => false)}
  end

  def profile2
   @orders = User.current.orders.where(:work_state => %w(draft saved_draft))
   render :json => {:to_whom => 'client', :data => render_to_string("profiles/profile2.html.haml", :layout => false)}

  end

  def profile3
   @orders = User.current.orders.where(:work_state => %w(work_accepted))
   render :json => {:to_whom => 'client', :data => render_to_string("profiles/profile3.html.haml", :layout => false)}

  end
  
  def profile4
   @orders = User.current.orders.where(:work_state => %w(sent_to_moderator moderator_suggested specialist_agreed specialist_disagreed client_agreed in_work))
   render :json => {:data => render_to_string("profiles/profile4.html.haml", :layout => false)}
  end
  
  def profile5
   @orders = User.current.orders.where(:work_state => %w(sent_to_moderator moderator_suggested specialist_agreed specialist_disagreed client_agreed in_work))
   render :json => {:data => render_to_string("profiles/profile5.html.haml", :layout => false)}
  end

  def profile6
   @orders = User.current.orders.where(:work_state => %w(sent_to_moderator moderator_suggested specialist_agreed specialist_disagreed client_agreed in_work))
   render :json => {:data => render_to_string("profiles/profile6.html.haml", :layout => false)}
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
