class DropMainPortfolios < ActiveRecord::Migration
  def change
    drop_table :main_portfolios
  end
end
