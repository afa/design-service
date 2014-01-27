# coding: utf-8
class CreateMainPortfolios < ActiveRecord::Migration
  def change
    create_table :main_portfolios do |t|
      t.references :owner, polymorphic: true
      t.references :portfolio

      t.timestamps
    end
    add_index :main_portfolios, [:owner_type, :owner_id]
    add_index :main_portfolios, :portfolio_id
  end
end
