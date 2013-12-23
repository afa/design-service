# coding: utf-8
class ChangePortfolioItemsHierarchy < ActiveRecord::Migration
  def change
    change_table :portfolio_items do |t|
      t.remove :specialist_id
      t.references :portfolio
    end
    add_index :portfolio_items, :portfolio_id
  end
end
