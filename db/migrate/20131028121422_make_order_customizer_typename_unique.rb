class MakeOrderCustomizerTypenameUnique < ActiveRecord::Migration
  def up
    remove_index :order_customizers, :typename
    add_index :order_customizers, :typename, unique: true
  end
  def down
    remove_index :order_customizers, :typename
    add_index :order_customizers, :typename
  end
end
