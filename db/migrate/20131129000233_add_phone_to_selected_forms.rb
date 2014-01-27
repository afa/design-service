# coding: utf-8
class AddPhoneToSelectedForms < ActiveRecord::Migration
  def change
    add_column :selected_forms, :phone, :string
  end
end
