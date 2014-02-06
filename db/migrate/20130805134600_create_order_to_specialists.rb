# coding: utf-8
class CreateOrderToSpecialists < ActiveRecord::Migration
  def change
    create_table :order_to_specialists do |t|
      t.references :executor, polymorphic: true
      t.text :description

      t.timestamps
    end
    add_index :order_to_specialists, [:executor_type, :executor_id]
  end
end
