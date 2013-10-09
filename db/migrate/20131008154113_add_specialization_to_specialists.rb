class AddSpecializationToSpecialists < ActiveRecord::Migration
  def up
   change_table :specialists do |t|
    t.references :specialization
   end
   change_table :specialist_groups do |t|
    t.references :specialization
   end
   add_index :specialists, [:specialization_id]
   add_index :specialist_groups, [:specialization_id]
  end
  def down
   remove_column :specialists, :specialization_id
   remove_column :specialist_groups, :specialization_id
  end
end
