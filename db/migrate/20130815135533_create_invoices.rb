class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :order
      t.decimal :amount
      t.references :specialist
      t.string :state
      t.timestamps
    end
  end
end
