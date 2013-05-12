class ReplanningEndorsementsController < InheritedResources::Base
  respond_to :html
  load_and_authorize_resource

  before_filter only: [:show] do
    @replanning_endorsement = @replanning_endorsement.decorate
  end

  def new
    @replanning_endorsement.replanning_attachments.build
    new!
  end
  def create
    @replanning_endorsement.build_order do |order|
      order.client = current_or_guest_user.client
    end
    create!{ resource }
  end
private
  def permitted_params
    params.permit(replanning_endorsement: [:developed_by_general_projector, :flat_area, :replanning_organization_licensed,
                                      replanning_attachments_attributes: [:file] ] )
  end
end