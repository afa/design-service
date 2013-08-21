class PlanDevelopmentsController < InheritedResources::Base
  #respond_to :html, except: [:create, :update]
  load_and_authorize_resource
  respond_to :json, only: [:update]

  before_filter only: [:show] do
    @plan_development = @plan_development.decorate
  end

  def new
    @plan_development = PlanDevelopment.generate(current_or_guest_user).decorate
  end

  #def create
  #  @plan_development = PlanDevelopment.make_order(permitted_params[:plan_development], current_or_guest_user)
  #  @plan_development.save!
  #  #render partial: 'form', locals: {plan_development: @plan_development}
  #end

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
  def attachments_text
    render_to_string('update',
                    layout: false, formats: [:html], handlers: [:haml])
  end
end
