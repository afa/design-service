class OrdersController < InheritedResources::Base
  load_and_authorize_resource
  def get_price
    respond_to do |format|
      format.json { render json: { price: resource.price } }
    end
  end
end
