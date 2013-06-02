class RemoveSpecializationFromPortfolioItems < ActiveRecord::Migration
  def change
    remove_column :portfolio_items, :specialization
  end
end
