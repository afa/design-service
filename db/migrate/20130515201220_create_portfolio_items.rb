# coding: utf-8
class CreatePortfolioItems < ActiveRecord::Migration
  def change
    create_table :portfolio_items do |t|
      t.string :title

      t.timestamps
    end
  end
end
