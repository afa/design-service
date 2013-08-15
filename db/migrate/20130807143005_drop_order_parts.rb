class DropOrderParts < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.table_exists?(:order_parts)
     drop_table :order_parts
    end
  end

  def down
  end
end
