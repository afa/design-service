# coding: utf-8
class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :order
      t.references :text

      t.timestamps
    end
    add_index :reviews, :order_id
    add_index :reviews, :text_id
    add_column :orders, :reviews_count, :integer, :default => 0
  end
end
