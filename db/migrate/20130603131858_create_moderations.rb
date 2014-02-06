# coding: utf-8
class CreateModerations < ActiveRecord::Migration
  def change
    create_table :moderations do |t|
      t.references :moderable, polymorphic: true
      t.boolean :accepted_first_stage, default: false
      t.boolean :accepted_final, default: false

      t.timestamps
    end
    add_index :moderations, [:moderable_type, :moderable_id]
  end
end
