class UserDecorator < Draper::Decorator
  delegate_all
  def admin_link
    h.link_to source.to_s, h.admin_user_path(source)
  end
  def orders_info_link
    source.orders_count > 0 ?  h.link_to("Заказы: #{orders_count}", h.admin_orders_path(client: source.id)) : nil
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
