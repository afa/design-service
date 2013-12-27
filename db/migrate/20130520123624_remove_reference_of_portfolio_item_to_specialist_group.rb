# coding: utf-8
class RemoveReferenceOfPortfolioItemToSpecialistGroup < ActiveRecord::Migration
  def change
   remove_column :portfolio_items, :specialist_group_id
  end
end
