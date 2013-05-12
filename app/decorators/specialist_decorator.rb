class SpecialistDecorator < Draper::Decorator
  delegate_all

  def toggle_like_text
    source.like_from?(h.current_user) ? 'Убрать из избранного' : 'Занести в избранное'
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
