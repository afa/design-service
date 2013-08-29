class MessageDecorator < Draper::Decorator
  delegate_all
  decorates_association :sender
  decorates_association :recipient
  decorates_association :attached_to
  decorates_association :moderation_info

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
