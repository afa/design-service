# coding: utf-8
class CreateEngineeringSystems < ActiveRecord::Migration
  def change
    create_table :engineering_systems do |t|
      t.string :address
      t.string :stage
      t.string :section
      t.boolean :electrical_equipment
      t.boolean :water_supply_and_sewerage
      t.boolean :heating
      t.boolean :ventilation
      t.boolean :water_supply_and_sewerage
      t.boolean :low_voltage_systems
      t.boolean :constructive_solutions
      t.boolean :water_supply_and_sewerage
      t.references :wishes
      t.timestamps
    end
  end
end
