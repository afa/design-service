class CreateOrderExecutorsTable < ActiveRecord::Migration
  def change
    create_table :order_executors, id: false do |t|
      t.references :order
      t.references :specialist
    end
    add_index :order_executors, :order_id
    add_index :order_executors, :specialist_id
  end
end
