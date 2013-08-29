class ModerationDecorator < Draper::Decorator
  delegate_all

  def to_s
    # h.content_tag :div do
      # source.status
    # end
    h.render partial: 'moderations/moderation', locals: {moderation: self}
  end

  def status
    I18n.t "moderation.status.#{source.status}"
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
