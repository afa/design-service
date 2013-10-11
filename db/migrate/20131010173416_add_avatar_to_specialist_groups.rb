class AddAvatarToSpecialistGroups < ActiveRecord::Migration
  def change
    add_column :specialist_groups, :avatar, :string
  end
end
