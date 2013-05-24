class SpecialistsController < InheritedResources::Base
  respond_to :html, except: [:toggle_like]
  has_scope :by_specialization, as: :specialization, only: [:index]
  load_and_authorize_resource
  custom_actions resource: [:toggle_like]

  before_filter only: [:show, :toggle_like] do
    @specialist = @specialist.decorate
  end

  def toggle_like
    authenticate_user!
    @specialist.toggle_like_from(current_user)
    respond_to do |format|
      format.json { render(json: { toggle_like_text: @specialist.toggle_like_text }) }
    end
  end
private
  def build_resource
    @specialist ||= super.tap{|s| s.profile = current_user }
  end
  def permitted_params
    params.permit(specialist: [:specialization, :acreditation_level, portfolio_photos_attributes: [:file]] )
  end
end