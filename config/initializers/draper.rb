class Draper::Decorator
  def render_attribute_label(attribute)
    helpers.content_tag(:div, class: 'label') do
      I18n.t("activerecord.attributes.#{source.class.model_name.underscore}.#{attribute}")
    end
  end
  # options can be {boolean: true}
  def render_attribute_value(attribute, options = {})
    helpers.content_tag(:div, class: 'value') do
      if options[:boolean] || column_for_attribute(attribute).try(&:type) == :boolean
        send(attribute) ? 'Да' : 'Нет'
      else
        send(attribute).to_s
      end
    end
  end
  def render_attribute(attribute, options = {})
    helpers.content_tag(:div, class: ['render_attribute', attribute]) do
      (render_attribute_label(attribute) + render_attribute_value(attribute, options)).html_safe
    end
  end
end