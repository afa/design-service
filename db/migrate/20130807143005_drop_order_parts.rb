class DropOrderParts < ActiveRecord::Migration
  def up
    drop_table :order_parts
  end

  def down
  end
end
