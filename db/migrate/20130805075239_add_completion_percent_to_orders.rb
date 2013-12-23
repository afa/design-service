# coding: utf-8
class AddCompletionPercentToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :completion_percent, :integer, default: 0
  end
end
