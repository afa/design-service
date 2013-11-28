class AddColumnsForEngineeringProjectsToSelectedForms < ActiveRecord::Migration
  def change
    add_column :selected_forms, :address, :string
    add_column :selected_forms, :stage, :string
    add_column :selected_forms, :section, :string
    add_column :selected_forms, :electrical_equipment, :boolean
    add_column :selected_forms, :water_supply_and_sewerage, :boolean
    add_column :selected_forms, :heating, :boolean
    add_column :selected_forms, :ventilation, :boolean
    add_column :selected_forms, :low_voltage_systems, :boolean
    add_column :selected_forms, :constructive_solutions, :boolean
  end
end
