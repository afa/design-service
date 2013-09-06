class CreateSpecialistGroupsSpecialists < ActiveRecord::Migration
  def change
    create_table :specialist_groups_specialists do |t|
      t.references :specialist
      t.references :specialist_group
    end
    add_index :specialist_groups_specialists, :specialist_id
    add_index :specialist_groups_specialists, :specialist_group_id
    
    remove_column :specialists, :specialist_group_id
  end
end
