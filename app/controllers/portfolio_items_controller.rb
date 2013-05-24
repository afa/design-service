class PortfolioItemsController < InheritedResources::Base
  load_and_authorize_resource
  def new
    @portfolio_item.build_photo_collection
    @portfolio_item.photo_collection.photos.build
    new!
  end
private
  def permitted_params
    params.permit(portfolio_item: [:title, photo_collection_attributes: { photos_attributes: [:photo, :_destroy]}])
  end
end
