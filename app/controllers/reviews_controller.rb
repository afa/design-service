class ReviewsController < InheritedResources::Base
  respond_to :html
  load_and_authorize_resource :order
  load_and_authorize_resource :review, :through => :order
  belongs_to :order

private
  def build_resource
    get_resource_ivar || set_resource_ivar( super.tap{|r| r.build_text} )
  end
  def permitted_params
    params.permit({review: [text_attributes: [:text]]})
  end
end
