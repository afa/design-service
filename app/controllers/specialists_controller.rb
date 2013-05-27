class SpecialistsController < InheritedResources::Base
  include LikeableResource
  has_scope :by_specialization, as: :specialization, only: [:index]
  load_and_authorize_resource
  respond_to :html, except: [:upvote_like, :downvote_like, :toggle_like]

  before_filter only: [:show] do
    @specialist = @specialist.decorate
  end
private
  def build_resource
    @specialist ||= super.tap{|s| s.profile = current_user }
  end
  def permitted_params
    params.permit(specialist: [:specialization, :acreditation_level, portfolio_photos_attributes: [:file]] )
  end
end