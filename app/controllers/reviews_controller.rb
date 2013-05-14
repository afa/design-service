class ReviewsController < InheritedResources::Base
  respond_to :html
  load_and_authorize_resource
  
private
  def review_params
    params.permit(review: [:order, :text])
  end
end
