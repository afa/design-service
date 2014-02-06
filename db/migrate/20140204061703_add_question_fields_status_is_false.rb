class AddQuestionFieldsStatusIsFalse < ActiveRecord::Migration
  def up
  	add_column :question_fields, :status_is_false, :boolean, :null => false, :default => false
  end

  def down
  	remove_column :question_fields, :status_is_false
  end
end