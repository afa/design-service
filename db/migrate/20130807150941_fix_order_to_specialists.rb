# coding: utf-8
class FixOrderToSpecialists < ActiveRecord::Migration
  def change
    change_table :order_to_specialists do |t|
      t.remove :executor_id
      t.remove :executor_type
    end
  end
end
