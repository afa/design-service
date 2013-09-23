class PortfoliosController < InheritedResources::Base
  belongs_to :specialist, :specialist_group, optional: true, polymorphic: true
  respond_to :json
  custom_actions resource: [:edit_form], collection: [:new_form]
  def new_form; end
  def edit_form; end
protected
  def permitted_params
    params.permit(portfolio: [:name, :description])
  end
end
