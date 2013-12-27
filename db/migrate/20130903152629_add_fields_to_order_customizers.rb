# coding: utf-8
class AddFieldsToOrderCustomizers < ActiveRecord::Migration
  def change
    add_column :order_customizers, :description, :text
    add_column :order_customizers, :typename, :string
  end
end
