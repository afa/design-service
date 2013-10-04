class RemoveOrdersWoClient < ActiveRecord::Migration
  def up
    Order.find_each do |order|
      order.destroy  unless order.client
    end
  end

  def down
  end
end
