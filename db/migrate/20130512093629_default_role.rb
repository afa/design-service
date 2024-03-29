class DefaultRole < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, default: 'client'
    User.find_each do |user|
      user.update_attribute(role: 'client')  if !user.role || user.role.blank?
    end
  end
end
