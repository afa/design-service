class PlanDevelopmentsController < InheritedResources::Base
  respond_to :html

  def create
  # here we should fill order etc
    @plan_development = PlanDevelopment.new(permitted_params).decorate
    @plan_development.build_order do |order|
      order.client = current_or_guest_user
    end
    create!{ resource }
  end
  def new
    @plan_development = PlanDevelopment.new.decorate
    @plan_development.build_family_composition
    @plan_development.build_comment
    @plan_development.build_attachment
  end

private
  def disable_form?
    action_name == 'show'
  end
  helper_method :disable_form?

  def permitted_params
    params.permit(plan_development: [:big_kitchen, :cabinet_needed, :cloakroom_needed,
                                      :join_kitchen_with_living_room, :num_bedrooms, :num_builtin_closets,
                                      :num_guests, :washing_room_needed, :num_plans,
                                      :num_standpipes,
                                      :address, :floor, :section,
                                      family_composition_attributes: [:first_line, :second_line],
                                      attachment_attributes: :file,
                                      comment_attributes: :text ] )
  end
end
