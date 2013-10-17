class TransactionDecorator < Draper::Decorator
  delegate_all

  def source
   object.source.nil? ? '' : "#{object.source.class.name} №#{object.source.id}"
  end
  def destination
   object.destination.nil? ? '' : "#{object.destination.class.name} №#{object.destination.id}"
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
