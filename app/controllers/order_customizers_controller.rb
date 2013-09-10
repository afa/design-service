class OrderCustomizersController < ApplicationController
  respond_to :json, only: [:update]
  before_filter :load_draft, only: [:show]

private

  def load_draft
    @selected_form = SelectedForm.find_or_create_order( SelectedForm.by_type(params[:type]) )
  end

  def resource
    @selected_form
  end
  
  helper_method :resource
end
