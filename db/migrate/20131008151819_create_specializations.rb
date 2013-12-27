# coding: utf-8
class CreateSpecializations < ActiveRecord::Migration
  def change
    create_table :specializations do |t|
      t.string :name
      t.string :sub_name
      t.string :title
      t.string :group_title
      t.timestamps
    end
  end
end
