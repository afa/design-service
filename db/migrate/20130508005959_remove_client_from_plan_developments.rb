class RemoveClientFromPlanDevelopments < ActiveRecord::Migration
  def up
    remove_column :plan_developments, :client
    PlanDevelopment.all.each do |plan_development|
      plan_development.build_order  if !plan_development.order
      plan_development.order.client = plan_developments.client  if !plan_development.order.client
    end
  end

  def down
    add_column :plan_developments, :client, :string
    plan_development.client = plan_development.order.client  if plan_development.order
  end
end
