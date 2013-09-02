class AddNameToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :name, :string
  end
end
