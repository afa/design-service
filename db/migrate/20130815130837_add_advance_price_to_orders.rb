class AddAdvancePriceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :advance_price, :decimal, precision: 10, scale: 2
  end
end
