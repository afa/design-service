class ReplanningEndorsementsController < InheritedResources::Base
  respond_to :html
  load_and_authorize_resource

  before_filter only: [:show] do
    @replanning_endorsement = @replanning_endorsement.decorate
  end

  def new
    @replanning_endorsement = ReplanningEndorsement.generate
    new!
  end

  def create
    @replanning_endorsement = ReplanningEndorsement.make_order(permitted_params[:replanning_endorsement], current_or_guest_user)
    @replanning_endorsement.save!
    render partial: 'form'
  end

  respond_to :json, only: :update

private
  def permitted_params
    params.permit(replanning_endorsement: [:developed_by_general_projector, :flat_area, :replanning_organization_licensed,
                                      replanning_attachments_attributes: [:file] ] )
  end
end