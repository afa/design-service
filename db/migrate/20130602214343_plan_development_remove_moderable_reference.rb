# coding: utf-8
class PlanDevelopmentRemoveModerableReference < ActiveRecord::Migration
  def change
    change_table :plan_developments do |t|
      t.remove :comment_id
      t.remove :family_composition_id
      t.text :comment
      t.text :family_composition
    end
  end
end
