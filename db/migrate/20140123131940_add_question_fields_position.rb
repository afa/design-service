class AddQuestionFieldsPosition < ActiveRecord::Migration
  def up
  	add_column :question_fields, :position, :integer, :null => true
  end

  def down
  	remove_column :question_fields, :position
  end
end
