class UserDecorator < Draper::Decorator
  delegate_all

  def admin_link
    h.link_to source.to_s, h.admin_user_path(source)
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
