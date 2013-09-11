class SelectedFormsController < InheritedResources::Base
  respond_to :json, only: [:update]
  before_filter :load_draft, only: [:show]

  def update
    resource.update_attributes!(permitted_params[:selected_form])
    respond_with do |format|
      format.json { render json: {text: attachments_text} }
    end
  end

protected
  def permitted_params
    params.permit(selected_form: [:room_space, :interior_style, :interior_style_comment, :show_results,:wishes])
  end

  def attachments_text
    render_to_string(partial: 'attachments/list_of_attachments',
                    locals: {attachments: resource.attachments, has_remove_button: true},
                    formats: [:html], handlers: [:haml])
  end

  def load_draft
    @selected_form = SelectedForm.find_or_create_order( SelectedForm.by_type(typename) ) do |selected_form|
      selected_form.order_customizer = OrderCustomizer.by_type(typename)
    end
  end

  def typename
    params[:type]
  end
end
