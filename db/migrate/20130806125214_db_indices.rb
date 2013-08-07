class DbIndices < ActiveRecord::Migration
  def change
    add_index :messages, :sender_id
    add_index :messages, [:recipient_type, :recipient_id]
    add_index :orders, [:orderable_type, :orderable_id]
    add_index :photo_collections, [:imageable_type, :imageable_id]
    add_index :plan_developments, :attachment_id
    add_index :portfolio_items, :specialist_id
    add_index :purchases, :orders_id
    add_index :purchases, :users_id
    add_index :specialists, :specialist_group_id
  end
end
