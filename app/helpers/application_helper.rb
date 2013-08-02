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
  def greating_name(user)
    "#{user.name} [#{user.username}]"
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end