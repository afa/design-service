# coding: utf-8
class DeletePriceFromPlanDevelopments < ActiveRecord::Migration
  def change
    change_table :plan_developments do |t|
      t.remove :price
    end
  end
end
