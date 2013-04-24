class SpecialistsController < InheritedResources::Base
  respond_to :html
  before_filter :authenticate_user!, except: [:index]
  has_scope :by_specialist_type, as: :specialist_type, only: :index

private
  def build_resource
    @specialist ||= begin
      obj = super
      obj.profile = current_user
      obj
    end
  end
  def permitted_params
    params.permit(specialist: [:specialist_type, :acreditation_level, portfolio_photos_attributes: [:file]] )
  end
end