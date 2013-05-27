class RemoveKitchenSizeChangeTypeOfbigKitchen < ActiveRecord::Migration
  def change
    change_table :plan_developments do |t|
      t.remove :kitchen_size
      t.remove :big_kitchen
      t.string :big_kitchen
    end
  end
end
