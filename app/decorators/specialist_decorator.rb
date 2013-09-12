class SpecialistDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def positive_feedback
    source.positive_feedback
  end
  def negative_feedback
    "-#{source.negative_feedback}"
  end

  def link_to_profile_admin
    h.link_to user.to_s, h.admin_user_path(user)
  end

  def orders_info
    h.link_to  'Назначенные заказы', h.admin_orders_path(executor: source.id)
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
    user.decorate.avatar(options)
  end
  def to_s
    source.to_s
  end
end
