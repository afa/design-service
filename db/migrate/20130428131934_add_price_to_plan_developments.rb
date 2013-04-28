class AddPriceToPlanDevelopments < ActiveRecord::Migration
  def change
    add_column :plan_developments, :price, :string
  end
end
