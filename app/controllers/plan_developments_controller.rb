class PlanDevelopmentsController < InheritedResources::Base
  #respond_to :html, except: [:create, :update]
  respond_to :html, :json
  load_and_authorize_resource
  respond_to :json, only: [:update]

  before_filter :load_draft, only: [:new, :edit, :start_count, :auto_price]
  before_filter except: [:index] do
    @plan_development = @plan_development.decorate
  end

  def start_count
   if @plan_development.price.to_f > 0.0
    render :json => {:price => @plan_development.price}
   else
    render :json => {}
   end
  end

  def auto_price
   if @plan_development.price.to_f > 0.0
    render :json => {:price => @plan_development.price}
   else
    render :json => {:price => @plan_development.locate_price}
   end
  end

  def to_moderator
   @plan_development.update_attributes permitted_params[:plan_development]
   @plan_development.order.send_to_moderator
   render :json => {}
  end

private
  def permitted_params
    params.permit(plan_development: [:big_kitchen, :cabinet_needed, :cloakroom_needed,
                                      :join_kitchen_with_living_room, :num_bedrooms, :num_builtin_closets,
                                      :num_guests, :washing_room_needed, :num_plans,
                                      :num_standpipes, :num_rooms,
                                      :address, :floor, :section,
                                      :family_composition_first_line,
                                      :men_total, :women_total, :below_10, :beyond_10_15, :above_15,
                                      :comment,:flat_area
                                    ] )
  end

  def load_draft
    @plan_development = PlanDevelopment.find_or_create_order
  end
end
