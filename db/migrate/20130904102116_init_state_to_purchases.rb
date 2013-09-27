class InitStateToPurchases < ActiveRecord::Migration
  def up
   add_column :purchases, :state, :string
  end

  def down
   remove_column :purchases, :state
  end
end
