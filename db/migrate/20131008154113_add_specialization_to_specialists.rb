class AddSpecializationToSpecialists < ActiveRecord::Migration
  def change
   change_table :specialists do |t|
    t.references :specialization
   end
   change_table :specialist_groups do |t|
    t.references :specialization
   end
   add_index :specialists, [:specialization_id]
   add_index :specialist_groups, [:specialization_id]
  end
end
