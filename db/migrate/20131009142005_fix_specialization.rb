class FixSpecialization < ActiveRecord::Migration
  def change
    remove_column :specialists, :specialization_id
    rename_column :specialist_groups, :specialization, :specialization_string
  end
end
