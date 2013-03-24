module ApplicationHelper
  def site_name
    I18n.t "title"
  end
  def subtitle
    I18n.t "#{controller_name.underscore}.title", default: ''
  end
  def title
    "#{site_name}." + (subtitle.empty? ? '': " #{subtitle}.")
  end
end
