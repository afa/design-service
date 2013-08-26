class AttachmentDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def link
    helpers.link_to file.filename, file.url
  end

  def kind(index = nil)
    kind_name = source.kind
    if kind_name && !kind_name.blank?
      I18n.t "attachment_kinds.#{kind_name}"
    else
      "План #{index + 1}"
    end
  end
end
