# coding: utf-8
class AddSpecPriceToOrder < ActiveRecord::Migration
  def change
   change_table :orders do |t|
    t.decimal :specialist_price, precision: 10, scale: 2
   end
  end
end
