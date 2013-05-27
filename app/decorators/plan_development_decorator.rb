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
  def order_info_link
    h.link_to 'Информация о заказе', h.admin_order_path(order.id)
  end
  def attachment_info
    source.attachment ? source.attachment.decorate.link : ''
  end
end
