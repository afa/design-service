class ChangeStatisIsTrueForQuestion < ActiveRecord::Migration
  def up
  	remove_column :questions, :statis_is_true
  	add_column :question_fields, :statis_is_true, :boolean, :null => true
  end

  def down
  	add_column :questions, :statis_is_true, :boolean, :null => true
  	remove_column :question_fields, :statis_is_true
  end
end
