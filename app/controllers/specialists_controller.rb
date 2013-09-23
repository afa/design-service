class SpecialistsController < InheritedResources::Base
  respond_to :json, only: [:update]
  has_scope :by_order, only: [:index]
  load_and_authorize_resource

  before_filter only: [:show] do
    @specialist = @specialist.decorate
  end
private
  def resource
    get_resource_ivar || set_resource_ivar(super.decorate)
  end
  def collection
    get_collection_ivar || set_collection_ivar(SpecialistDecorator.decorate(end_of_association_chain))
  end
  def build_resource
    @specialist ||= super.tap{|s| s.user = current_user }
  end

  def permitted_params
    params.permit(specialist: [:bio_info, :work_info] )
  end
end
