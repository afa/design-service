# coding: utf-8
class AddCommentToPlanDevelopments < ActiveRecord::Migration
  def change
    change_table :plan_developments do |t|
      t.references :comment
    end
  end
end
