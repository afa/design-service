class AddOrdersReviewAdmin < ActiveRecord::Migration
  def change
  	add_column :orders, :review_admin, :boolean, :default => false
  end
end
