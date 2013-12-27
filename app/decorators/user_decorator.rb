# coding: utf-8
class UserDecorator < Draper::Decorator
  delegate_all
  def to_s
    h.link_to source.to_s, h.admin_user_path(source)
  end
  alias_method :admin_link, :to_s
  def orders_info_link
    source.orders_count > 0 ?  h.link_to("Заказы: #{orders_count}", h.admin_orders_path(client: source.id)) : nil
  end
  def specialist_info_link
    source.specialist ?  h.link_to("Профиль специалиста", h.admin_specialist_path(source.specialist.id)) : nil
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def avatar(options = {})
    h.image_tag(source.avatar.url, options)
  end
  def phone; '+7(XXX)-XXX-XXXX'; end
end
