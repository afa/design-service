class OrdersController < InheritedResources::Base
  load_and_authorize_resource
  custom_actions resource: [:details, :agree_price, :accept_work], collection: []
  before_filter except: [:index,:profile1,:profile2,:profile3] do
    @order = @order.decorate
  end
  before_filter only: [:index] do
    @orders = OrderDecorator.decorate_collection(@orders)
  end
  respond_to :json
  def get_price
    respond_to do |format|
      format.json { render json: { price: resource.price } }
    end
  end
  def agree_price
    resource.agree
    respond_with(resource)
  end
  def accept_work
    resource.accept_work
    respond_with(resource)
  end

  def profile1

  end

  def profile2

  end

  def profile3

  end

end
