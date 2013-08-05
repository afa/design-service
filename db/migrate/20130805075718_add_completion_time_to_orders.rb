class AddCompletionTimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :completion_time, :date
  end
end
