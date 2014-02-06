# coding: utf-8
class AddSpecialistRefereceToPortfolios < ActiveRecord::Migration
  def change
    change_table :portfolios do |t|
      t.references :specialist
      t.references :specialist_group
    end
  end
end
