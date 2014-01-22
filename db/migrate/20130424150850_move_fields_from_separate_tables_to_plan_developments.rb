# coding: utf-8
class MoveFieldsFromSeparateTablesToPlanDevelopments < ActiveRecord::Migration
  def change
    change_table :plan_developments do |t|
      t.string :address
      t.string :floor
      t.string :section
      t.integer :num_standpipes
      t.references :family_composition
      t.remove :flat_info_id
    end
  end
end
