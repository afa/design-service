class MakePortfolioPortfolioItemsAssociationHabtm < ActiveRecord::Migration
  def change
    create_table :portfolio_items_portfolios do |t|
      t.references :portfolio
      t.references :portfolio_item
    end
    add_index :portfolio_items_portfolios, :portfolio_id
    add_index :portfolio_items_portfolios, :portfolio_item_id

    remove_column :portfolio_items, :portfolio_id
  end
end
