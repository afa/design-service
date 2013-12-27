# coding: utf-8
class AddAvatarAsAFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
  end
end
