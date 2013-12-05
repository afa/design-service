class EngineeringSystemsController < InheritedResources::Base
  load_and_authorize_resource
  respond_to :json, only: [:update]

  before_filter :load_draft, only: [:new, :edit]
  before_filter except: [:index] do
    @engineering_system = @engineering_system.decorate
  end

private
  def permitted_params
    params.permit(:engineering_system => [:address, :stage, :wishes, :section, :electrical_equipment,
                                          :water_supply_and_sewerage, :heating, :ventilation,
                                          :constructive_solutions, :light_control, :access_control, 
                                          :mood_control])
  end

  def load_draft
    @engineering_system = EngineeringSystem.find_or_create_order
  end
end
