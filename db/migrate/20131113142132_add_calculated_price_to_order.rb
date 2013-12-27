# coding: utf-8
class AddCalculatedPriceToOrder < ActiveRecord::Migration
  def change
   change_table :orders do |t|
    t.decimal :calculated_price, :precision => 10, :scale => 2
   end
  end
end
