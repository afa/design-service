# coding: utf-8
class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :orderable, polymorphic: true
      t.references :client, null: false
      t.string :completion_status

      t.timestamps
    end
    add_index :orders, :orderable_id
    add_index :orders, :client_id
  end
end
