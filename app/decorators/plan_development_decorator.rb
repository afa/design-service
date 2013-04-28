class PlanDevelopmentDecorator < Draper::Decorator
  delegate_all
  #decorates_association :attachment
  
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def attachment
    source.attachment ? source.attachment.decorate.link : ''
  end
end
