class AddCounterCacheForOrders < ActiveRecord::Migration
  def up
    add_column :users, :orders_count, :integer, :default => 0
    User.reset_column_information
    User.all.each do |user|
      user.update_attribute :orders_count, user.orders.count
    end
  end

  def down
    remove_column :users, :orders_count
  end
end
