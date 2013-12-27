# coding: utf-8
class PlanDevelopmentRemoveClient < ActiveRecord::Migration
  def change
   if PlanDevelopment.new.attributes.has_key?("client")
    remove_column :plan_developments, :client
   end
  end
end
