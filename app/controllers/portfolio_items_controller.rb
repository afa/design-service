class PortfolioItemsController < InheritedResources::Base
  belongs_to :portfolio, optional: true
  load_and_authorize_resource
  respond_to :json
  before_filter only: [:create] do
    parent.portfolio_items << resource
  end
private
  def permitted_params
    params.permit(portfolio_item: [:title, :photo])
  end
end
