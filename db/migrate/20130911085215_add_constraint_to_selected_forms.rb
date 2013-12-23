# coding: utf-8
class AddConstraintToSelectedForms < ActiveRecord::Migration
  def change
    SelectedForm.where(order_customizer_id: nil).delete_all
    change_column :selected_forms, :order_customizer_id, :integer, null: false
  end
end
