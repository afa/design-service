# coding: utf-8
class PlanDevelopmentRemoveClientId < ActiveRecord::Migration
  def change
    remove_column :plan_developments, :client_id
  end
end
