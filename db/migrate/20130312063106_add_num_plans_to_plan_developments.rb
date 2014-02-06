# coding: utf-8
class AddNumPlansToPlanDevelopments < ActiveRecord::Migration
  def change
    add_column :plan_developments, :num_plans, :integer
  end
end
