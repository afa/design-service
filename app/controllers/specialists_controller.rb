class SpecialistsController < InheritedResources::Base
  respond_to :html
  before_filter :authenticate_user!, except: [:index]

  # GET /specialists
  # GET /specialists.json
  def index
    specialist_type = params[:specialist_type]
    if !specialist_type || specialist_type.blank? || specialist_type == :all
      @specialists = Specialist.all
    else
      @specialists = Specialist.where(specialist_type: Specialist::SPECIALIST_TYPE_ID_BY_NAME[specialist_type])
    end
  end

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