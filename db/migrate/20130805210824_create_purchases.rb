class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :orders
      t.float :amount
      t.references :users
      t.timestamps
    end
  end
end
