class PlanDevelopmentDecorator < Draper::Decorator
  delegate_all
  #decorates_association :attachment

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def attachment_info
    source.attachment ? source.attachment.decorate.link : ''
  end
  def render_attribute(attribute)
    helpers.content_tag(:div, class: ['attribute', attribute]) do
      result = ""
      result << helpers.content_tag(:div, class: 'label') do
        I18n.t("activerecord.attributes.#{source.class.model_name.underscore}.#{attribute}")
      end
      result << helpers.content_tag(:div, class: 'value') do
        if column_for_attribute(attribute).try(&:type) == :boolean
          send(attribute) ? 'Да' : 'Нет'
        else
          send(attribute).to_s
        end
      end
      result.html_safe
    end
  end
  def kitchen_size
    PlanDevelopment::KITCHEN_SIZE.detect{|k,v| k == big_kitchen}.last
  end
  def num_guests_description
    num_guests ? PlanDevelopment::NUM_GUESTS[num_guests].last : 'Не указано'
  end

end
