class RemoveWhatMaterialsFromSelectedForms < ActiveRecord::Migration
  def up
    remove_column :selected_forms, :what_materials
  end

  def down

  end
end
