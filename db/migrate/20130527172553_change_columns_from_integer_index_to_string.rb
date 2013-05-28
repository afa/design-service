class ChangeColumnsFromIntegerIndexToString < ActiveRecord::Migration
  def change
    change_table :plan_developments do |t|
      t.remove :num_guests
#      t.remove :kitchen_size
      
      t.string :num_guests
#      t.string :kitchen_size
    end
  end
end
