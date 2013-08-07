class FixPurchases < ActiveRecord::Migration
  def up
   if (Purchase.new.attributes.has_key?(:orders_id.to_s))
    puts "rm orderss"
    remove_column :purchases, :orders_id
   end
   add_column :purchases, :order_id, :integer
   if (Purchase.new.attributes.has_key?(:users_id.to_s))
    puts "rm userss"
    remove_column :purchases, :users_id
   end
   add_column :purchases, :user_id, :integer
  end

  def down
   remove_column :purchases, :user_id
   remove_column :purchases, :order_id
  end
end
