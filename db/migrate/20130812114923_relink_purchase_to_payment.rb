# coding: utf-8
class RelinkPurchaseToPayment < ActiveRecord::Migration
  def up
   if (Purchase.new.attributes.has_key?(:order_id.to_s))
   end
   add_column :purchases, :payment_id, :integer
  end

  def down
   remove_column :purchases, :payment_id
  end
end
