class ProfilesController < InheritedResources::Base
  defaults singleton: true
  before_filter :authenticate_user!

  def specialists
    @specialists = current_user.liked_specialists.decorate
  end

  def orders
    @orderable = current_user.orders.map(&:orderable).map(&:decorate)
  end

  def page_subtitle
    case params[:action]
    when 'orders' then 'МОИ ЗАКАЗЫ'
    else super
    end
  end
protected
  def begin_of_association_chain
    current_user
  end
end
