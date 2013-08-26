class PlanDevelopmentsController < InheritedResources::Base
  #respond_to :html, except: [:create, :update]
  load_and_authorize_resource
  respond_to :json, only: [:update]

  before_filter :load_draft, only: [:new, :edit]
  before_filter except: [:index] do
    @plan_development = @plan_development.decorate
  end

  def update
    resource.update_attributes(permitted_params[:plan_development])
    resource.save!
    respond_with do |format|
      format.json { render json: {text: attachments_text} }
    end
  end

private
  def permitted_params
    params.permit(plan_development: [:big_kitchen, :cabinet_needed, :cloakroom_needed,
                                      :join_kitchen_with_living_room, :num_bedrooms, :num_builtin_closets,
                                      :num_guests, :washing_room_needed, :num_plans,
                                      :num_standpipes,
                                      :address, :floor, :section,
                                      :family_composition_first_line, :family_composition_second_line, :comment,
                                      :flat_area,
                                      attachments_attributes: [:file, :kind, :_destroy]
                                    ] )
  end

  def load_draft
    @plan_development = PlanDevelopment.find_or_create_order
  end

  def attachments_text
    render_to_string(partial: 'attachments/list_of_attachments',
                    locals: {attachments: resource.attachments},
                    formats: [:html], handlers: [:haml])
  end
end
