# coding: utf-8
class AddStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :work_state, :string, default: 'empty_draft'
    add_column :orders, :payment_state, :string, default: 'not_paid'
  end
end
