class SpecialistDecorator < Draper::Decorator
  delegate_all

  def toggle_like_text
    source.like_from?(h.current_user) ? 'Убрать из избранного' : 'Занести в избранное'
  end

  def link_to_profile_admin
    h.link_to profile.to_s, h.admin_user_path(profile)
  end

  def specialist_type_name
    I18n.t 'specialist.titles.singular.' + Specialist::SPECIALIST_TYPE_NAME_BY_TYPE_ID[specialist_type]
  end

  def orders_info
    h.link_to  'Назначенные заказы', h.admin_orders_path(executor: source.id)
  end

  def to_s
    "#{specialist_type_name} #{source.to_s}"
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
