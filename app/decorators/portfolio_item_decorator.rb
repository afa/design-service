class PortfolioItemDecorator < Draper::Decorator
  delegate_all
  def rating
    if rating >= 0
      h.content_tag :div, class: 'positiveRating' do
        "+#{source.rating}"
      end
    else
      h.content_tag :div, class: 'negativeRating' do
        source.rating
      end
    end
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
