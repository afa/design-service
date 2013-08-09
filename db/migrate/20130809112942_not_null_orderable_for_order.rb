class NotNullOrderableForOrder < ActiveRecord::Migration
  def change
    Order.where(orderable_id: nil).delete_all
    Order.where(orderable_type: nil).delete_all
    change_column :orders, :orderable_id, :integer, polymorphic: true, null: false
    change_column :orders, :orderable_type, :string, polymorphic: true, null: false
    remove_index :orders, [:orderable_id]
  end
end
