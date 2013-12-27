# coding: utf-8
class FixModerationsTable < ActiveRecord::Migration
  def change
    change_table :moderations do |t|
      t.remove :accepted_first_stage
      t.remove :accepted_final
      t.string :status, default: :not_accepted
    end
  end
end
