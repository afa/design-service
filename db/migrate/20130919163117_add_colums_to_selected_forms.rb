# coding: utf-8
class AddColumsToSelectedForms < ActiveRecord::Migration
  def change
    add_column :selected_forms, :room_name, :string
    add_column :selected_forms, :what_materials, :string
  end
end
