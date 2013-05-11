class AddPriceToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.decimal :price, precision: 10, scale: 2
    end
  end
end
