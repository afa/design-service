# coding: utf-8
class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :source, :polymorphic => true
      t.references :destination, :polymorphic => true
      t.decimal :amount, :scale => 4, :precision => 12
      t.references :user, :polymorphic => true
      t.references :order
      t.timestamps
    end
  end
end
