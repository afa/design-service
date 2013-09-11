class EngineeringSystemsController < InheritedResources::Base
  load_and_authorize_resource
  respond_to :json, only: [:update]

  before_filter :load_draft, only: [:new, :edit]
  before_filter except: [:index] do
    @engineering_system = @engineering_system.decorate
  end

  def update
    resource.update_attributes!(permitted_params[:engineering_system])
    respond_with do |format|
      format.json { render json: {text: attachments_text} }
    end
  end

private
  def permitted_params
    params.permit(:engineering_system => [:address, :stage, :wishes, :section, :electrical_equipment,
                                          :water_supply_and_sewerage, :heating, :ventilation,
                                          :low_voltage_systems, :constructive_solutions])
  end

  def load_draft
    @engineering_system = EngineeringSystem.find_or_create_order
  end

  def attachments_text
    render_to_string(partial: 'attachments/list_of_attachments',
                    locals: {attachments: resource.attachments, has_remove_button: true},
                    formats: [:html], handlers: [:haml])
  end


end
