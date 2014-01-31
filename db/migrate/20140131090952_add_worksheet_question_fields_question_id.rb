class AddWorksheetQuestionFieldsQuestionId < ActiveRecord::Migration
  def up
  	add_column :worksheet_question_fields, :question_id, :integer, :null => true
  	add_index :worksheet_question_fields, :question_id
  end

  def down
  	remove_column :worksheet_question_fields, :question_id
  end
end
