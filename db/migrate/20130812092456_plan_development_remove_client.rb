class PlanDevelopmentRemoveClient < ActiveRecord::Migration
  def change
    remove_column :plan_developments, :client
  end
end
