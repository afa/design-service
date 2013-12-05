class SelectedFormsController < InheritedResources::Base
  respond_to :json, only: [:update]
  belongs_to :specialist_group, optional: true
  before_filter :load_draft, only: [:new, :edit]

  def new
    if !parent
      @work_doc_array = ['sweep_wall','floor_plans','ceiling_fixtures','draping_materials']
      render 'new'
    else
      render 'new_order_to_specialist'
    end
  end

  def show
    if resource.order_to_specialist?
      render 'show_order_to_specialist'
    else
      render 'show'
    end
  end
protected
  def permitted_params
    params.permit(selected_form: [:flat_area, :interior_style, :interior_style_comment,
      :show_results, :wishes, :typename, :room_name, :decorative_plaster, :wallpaper,
      :ceramic_tiles, :tree, :natural_stone, :cold_gamma, :bright_saturated_colors,
      :warm_color, :pastel_shades, :main_color, :show_results_different,
      :ceiling_dependence, :materials_designer_choise,
      :address, :stage, :section, :phone, :email,
      :electrical_equipment, :water_supply_and_sewerage, :heating, :ventilation, :low_voltage_systems, :constructive_solutions,
      floor_plans_attributes: [:id, :_destroy, :room, :artificial_cold, :artificial_warm,
      :carpet_or_printed_carpet, :stone, :tree]])
  end

  def load_draft
    if !parent
      @selected_form = SelectedForm.find_or_create_order( SelectedForm.by_type(typename) ) do |selected_form|
        selected_form.order_customizer = OrderCustomizer.by_type(typename)
      end
    else
      @selected_form = SelectedForm.find_or_create_order( parent.selected_forms ) do |selected_form|
        selected_form.order_customizer = parent.order_customizer
        selected_form.order.specialist_group = parent
      end
    end
    @selected_form.tap { |sf|
      sf.email = User.current.email  if User.current.client?
    }
  end

  def typename
    if !parent
      if params[:action] == 'new'
        params[:type]
      else
        resource.typename
      end
    else
      "#{parent.specialization.full_name}_specialist"
    end
  end
  helper_method :typename

  def page_subtitle
    I18n.t "titles.selected_form.#{typename}"
  end
end
