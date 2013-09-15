class SelectedFormsController < InheritedResources::Base
  respond_to :json, only: [:update]
  before_filter :load_draft, only: [:show]

protected
  def permitted_params
    params.permit(selected_form: [:room_space, :interior_style, :interior_style_comment, :show_results,:wishes, :typename])
  end

  def load_draft
    @selected_form = SelectedForm.find_or_create_order( SelectedForm.by_type(typename) ) do |selected_form|
      selected_form.order_customizer = OrderCustomizer.by_type(typename)
    end
  end

  def typename
    params[:type]
  end
  helper_method :typename
end
