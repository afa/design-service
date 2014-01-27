# coding: utf-8
class AddColumnCategoryToPortfolioItems < ActiveRecord::Migration
  def change
    add_column :portfolio_items, :specialization, :string
  end
end
