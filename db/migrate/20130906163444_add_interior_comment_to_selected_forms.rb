# coding: utf-8
class AddInteriorCommentToSelectedForms < ActiveRecord::Migration
  def change
    add_column :selected_forms, :interior_style_comment, :string
  end
end
