class AddLprToSpecialist < ActiveRecord::Migration
  def change
   add_column :specialists, :labor_participation, :decimal, :precision => 6, :scale => 4
   add_column :specialist_groups, :labor_participation, :decimal, :precision => 6, :scale => 4
  end
end
