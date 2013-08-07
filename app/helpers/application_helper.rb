module ApplicationHelper
  def greating_name(user)
    "#{user.name} [#{user.username}]"
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
