class AddColumnsPlanDevelopments < ActiveRecord::Migration
  def up
    add_column :plan_developments, :men_total, :integer
    add_column :plan_developments, :women_total, :integer
    add_column :plan_developments, :below_10, :boolean
    add_column :plan_developments, :beyond_10_15, :boolean
    add_column :plan_developments, :above_15, :boolean                
  end

  def down
    remove_column :plan_developments, :men_total  
    remove_column :plan_developments, :women_total  
    remove_column :plan_developments, :below_10  
    remove_column :plan_developments, :beyond_10_15  
    remove_column :plan_developments, :above_15                   
  end
end
