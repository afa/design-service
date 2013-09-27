class PlanDevelopmentsController < InheritedResources::Base
  #respond_to :html, except: [:create, :update]
  load_and_authorize_resource
  respond_to :json, only: [:update]

  before_filter :load_draft, only: [:new, :edit]
  before_filter except: [:index] do
    @plan_development = @plan_development.decorate
  end

private
  def permitted_params
    params.permit(plan_development: [:big_kitchen, :cabinet_needed, :cloakroom_needed,
                                      :join_kitchen_with_living_room, :num_bedrooms, :num_builtin_closets,
                                      :num_guests, :washing_room_needed, :num_plans,
                                      :num_standpipes, :num_rooms,
                                      :address, :floor, :section,
                                      :family_composition_first_line, :family_composition_second_line, :comment,
                                      :flat_area
                                    ] )
  end

  def load_draft
    @plan_development = PlanDevelopment.find_or_create_order
  end
end
