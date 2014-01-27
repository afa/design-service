# coding: utf-8
class AddEmailToSelectedForms < ActiveRecord::Migration
  def change
    add_column :selected_forms, :email, :string
  end
end
