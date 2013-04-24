class PlanDevelopmentsController < InheritedResources::Base

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
    params.require(:plan_development).permit( :big_kitchen, :cabinet_needed, :cloakroom_needed,
                                              :join_kitchen_with_living_room, :num_bedrooms, :num_builtin_closets,
                                              :num_guests, :washing_room_needed, :num_plans,
                                              :num_standpipes,
                                              :address, :floor, :section,
                                              family_composition_attributes: [:first_line, :second_line],
                                              attachment_attributes: :file,
                                              comment_attributes: :text
                                            )
  end
end
