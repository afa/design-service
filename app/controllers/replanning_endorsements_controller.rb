class ReplanningEndorsementsController < InheritedResources::Base
  respond_to :html
  load_and_authorize_resource
  respond_to :json, only: [:create, :update]

  before_filter :load_draft, only: [:new, :edit]
  before_filter except: [:index] do
    @replanning_endorsement = @replanning_endorsement.decorate
  end

  def to_moderator
   @replanning_endorsement.update_attributes permitted_params[:replanning_endorsement]
   @replanning_endorsement.order.send_to_moderator
   render :json => {}
  end

private
  def permitted_params
    params.permit(replanning_endorsement: [:developed_by_general_projector, :flat_area, :replanning_organization_licensed] )
  end

  def load_draft
    @replanning_endorsement = ReplanningEndorsement.find_or_create_order
  end
end
