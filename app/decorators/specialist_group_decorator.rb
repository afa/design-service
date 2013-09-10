class SpecialistGroupDecorator < Draper::Decorator
  delegate_all
  decorates_association :specialists
  decorates_association :portfolio_items

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def positive_feedback
    source.positive_feedback
  end
  def negative_feedback
    "-#{source.negative_feedback}"
  end
  def avatar(options = {})
    h.image_tag((source.avatar || source.build_avatar).photo.avatar_size.url, options)
  end
  def number_of_participants
    "#{source.number_of_participants} участников"
  end
  def to_s
    source.to_s
  end
end
