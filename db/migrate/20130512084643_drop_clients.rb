# coding: utf-8
class DropClients < ActiveRecord::Migration
  def change
    Order.find_each do |order|
      order.update_attribute(:client_id, order.client.profile_id)  if order.client
    end
    drop_table :clients
  end
end
