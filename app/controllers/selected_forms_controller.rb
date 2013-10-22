class SelectedFormsController < InheritedResources::Base
  respond_to :json, only: [:update]
  before_filter :load_draft, only: [:new, :edit]

protected
  def permitted_params
    params.permit(selected_form: [:flat_area, :interior_style, :interior_style_comment,
      :show_results, :wishes, :typename, :room_name, :decorative_plaster, :wallpaper,
      :ceramic_tiles, :tree, :natural_stone, :cold_gamma, :bright_saturated_colors,
      :warm_color, :pastel_shades, :main_color, :show_results_different,
      floor_plans_attributes: [:id, :_destroy, :room, :artificial_cold, :artificial_warm,
      :carpet_or_printed_carpet, :stone, :tree]])
  end

  def load_draft
    @selected_form = SelectedForm.find_or_create_order( SelectedForm.by_type(typename) ) do |selected_form|
      selected_form.order_customizer = OrderCustomizer.by_type(typename)
    end
  end

  def typename
    if params[:action] == 'new'
      params[:type]
    else
      resource.typename
    end
  end
  helper_method :typename

  def page_subtitle
    I18n.t "titles.selected_form.#{typename}"
  end
end
