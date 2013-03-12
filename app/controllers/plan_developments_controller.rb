class PlanDevelopmentsController < ApplicationController
  def new
    @plan_development = PlanDevelopment.new
    flat_info = @plan_development.build_flat_info
    flat_info.build_address
    flat_info.build_family_composition
    @plan_development.build_attachment
  end

  def create
    @plan_development = PlanDevelopment.new(params[:plan_development])
    #@flat_info = @plan_development.build_flat_info
    #@flat_info.build_address
    #@flat_info.build_family_composition
    
    if @plan_development.save
      flash[:notice] = 'Saved'
      redirect_to @plan_development, notice: 'Saved'
    else
      flash[:alert] = 'Error'
      render action: 'new'
    end
  end
  
  def show
    @plan_development = PlanDevelopment.find(params[:id])
  end
  def disable_form?
    action_name == 'show'
  end
  helper_method :disable_form?
end
