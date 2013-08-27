class ReplanningEndorsementsController < InheritedResources::Base
  respond_to :html
  load_and_authorize_resource
  respond_to :json, only: [:create, :update]

  before_filter :load_draft, only: [:new, :edit]
  before_filter except: [:index] do
    @replanning_endorsement = @replanning_endorsement.decorate
  end

  def update
    resource.update_attributes(permitted_params[:replanning_endorsement])
    resource.save!
    respond_with do |format|
      format.json { render json: {text: attachments_text} }
    end
  end

private
  def permitted_params
    params.permit(replanning_endorsement: [:developed_by_general_projector, :flat_area, :replanning_organization_licensed,
                                      attachments_attributes: [:file, :kind, :_destroy] ] )
  end

  def load_draft
    @replanning_endorsement = ReplanningEndorsement.find_or_create_order
  end

  def attachments_text
    render_to_string(partial: 'attachments/list_of_attachments',
                    locals: {attachments: resource.attachments},
                    formats: [:html], handlers: [:haml])
  end
end
