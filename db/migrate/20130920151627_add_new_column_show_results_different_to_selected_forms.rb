# coding: utf-8
class AddNewColumnShowResultsDifferentToSelectedForms < ActiveRecord::Migration
  def change
    add_column :selected_forms, :show_results_different, :string
  end
end
