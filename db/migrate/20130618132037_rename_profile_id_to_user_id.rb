class RenameProfileIdToUserId < ActiveRecord::Migration
  def change
    rename_column :specialists, :profile_id, :user_id
  end
end
