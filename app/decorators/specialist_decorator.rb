class SpecialistDecorator < Draper::Decorator
  delegate_all

  def positive_feedback
    source.positive_feedback
  end
  def negative_feedback
    "-#{source.negative_feedback}"
  end

  def toggle_like_text
    source.like_from?(h.current_user) ? 'Убрать из избранных' : 'В избранные'
  end

  def link_to_profile_admin
    h.link_to profile.to_s, h.admin_user_path(profile)
  end

  def orders_info
    h.link_to  'Назначенные заказы', h.admin_orders_path(executor: source.id)
  end

  def to_s
    "#{specialization} #{source.to_s}"
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
