# coding: utf-8
class RemoveFormPathFromOrderCustomizers < ActiveRecord::Migration
  def change
    remove_column :order_customizers, :form_path
    add_index :order_customizers, :typename
  end
end
