# coding: utf-8
class AddMissingFieldsToSelectedForms < ActiveRecord::Migration
  def change
    add_column :selected_forms, :ceiling_dependence, :boolean
    add_column :selected_forms, :materials_designer_choise, :boolean
  end
end
