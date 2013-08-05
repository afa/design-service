class ReplanningEndorsementDecorator < Draper::Decorator
  delegate_all
  decorates_association :order

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def border_class
    'border_x4'
  end
  def border_class_mild
    'border_x2'
  end
end
