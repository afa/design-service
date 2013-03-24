class PlanDevelopmentDecorator < Draper::Decorator
  delegate_all
  #decorates_association :flat_info
  #accepts_nested_attributes_for :flat_info
  #accepts_nested_attributes_for :attachment
  #attr_accessible :flat_info_attributes
  
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
