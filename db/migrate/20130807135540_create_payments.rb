class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user
      t.references :order
      t.string :state
      t.float :amount
      t.timestamps
    end
  end
end
