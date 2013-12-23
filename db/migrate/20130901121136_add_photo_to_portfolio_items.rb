# coding: utf-8
class AddPhotoToPortfolioItems < ActiveRecord::Migration
  def change
    add_column :portfolio_items, :photo, :string
  end
end
