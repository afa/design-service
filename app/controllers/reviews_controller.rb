class ReviewsController < InheritedResources::Base
  #load_and_authorize_resource :order
  #load_and_authorize_resource :review, :through => :order
  belongs_to :specialist, :specialist_group, :order, optional: true, polymorphic: true

private
  def permitted_params
    params.permit(review: [:text])
  end
end
