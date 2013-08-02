class PlanDevelopmentsController < InheritedResources::Base
  #respond_to :html, except: [:create, :update]
  load_and_authorize_resource
  respond_to :json, only: [:create, :update]

  before_filter only: [:show] do
    @plan_development = @plan_development.decorate
  end

  def new
    @plan_development = PlanDevelopment.generate.decorate
  end

  def create
    @plan_development = PlanDevelopment.make_order(permitted_params[:plan_development], current_or_guest_user)
    @plan_development.save!
    render partial: 'form'
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
                                      attachment_attributes: [:file]
                                    ] )
  end
end
