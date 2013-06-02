class CreateOrderParts < ActiveRecord::Migration
  def change
    create_table :order_parts do |t|
      t.references :order
      t.references :specialist
      t.string :status

      t.timestamps
    end
    add_index :order_parts, :order_id
    add_index :order_parts, :specialist_id

    drop_table :order_executors
  end
end
