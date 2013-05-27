class SpecialistsController < InheritedResources::Base
  has_scope :by_specialization, as: :specialization, only: [:index]
  load_and_authorize_resource

  before_filter only: [:show] do
    @specialist = @specialist.decorate
  end
private
  def build_resource
    @specialist ||= super.tap{|s| s.profile = current_user }
  end
  def permitted_params
    params.permit(specialist: [:specialization, :acreditation_level] )
  end
end