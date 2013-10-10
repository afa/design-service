class Admin::SpecializationController < ApplicationController
  respond_to :json
  def specialists
    @specialists = Specialization.find(params[:id]).specialists
    render json: @specialists
  end
  def specialist_groups
    @specialist_groups = Specialization.find(params[:id]).specialist_groups
    render json: @specialist_groups
  end
end
