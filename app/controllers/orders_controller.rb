class OrdersController < InheritedResources::Base
  load_and_authorize_resource
  before_filter except: [:index] do
    @order = @order.decorate
  end
  before_filter only: [:index] do
    @orders = OrderDecorator.decorate_collection(@orders)
  end
  def get_price
    respond_to do |format|
      format.json { render json: { price: resource.price } }
    end
  end
end
