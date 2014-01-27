# coding: utf-8
class AddDescriptionToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :description, :text
  end
end
