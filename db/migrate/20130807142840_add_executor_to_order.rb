# coding: utf-8
class AddExecutorToOrder < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.references :executor, polymorphic: true
    end
  end
end
