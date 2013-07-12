class PlanDevelopmentsController < InheritedResources::Base
  #respond_to :html, except: [:create, :update]
  load_and_authorize_resource
  respond_to :json, only: [:create, :update]

  before_filter only: [:show] do
    @plan_development = @plan_development.decorate
  end

  def new
    @plan_development = @plan_development.decorate
    @plan_development.join_kitchen_with_living_room = true
    @plan_development.big_kitchen = :greater_than_fifteen
    @plan_development.cloakroom_needed = true
    @plan_development.cabinet_needed = true
    @plan_development.num_guests = :zero
    @plan_development.washing_room_needed = true
    @plan_development.build_attachment
    @plan_development.num_plans = 1
  end

  def create
    @plan_development = PlanDevelopment.new(permitted_params[:plan_development]) do |plan|
      plan.build_order do |order|
        order.client = current_or_guest_user
      end
    end
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
                                      attachment_attributes: [:file]
                                    ] )
  end
end
