class AddWorksheetExperiencesQuestionFieldId < ActiveRecord::Migration
  def up
  	add_column :worksheet_experiences, :question_field_id, :integer, :null => false
  end

  def down
  	remove_column :worksheet_experiences, :question_field_id
  end
end
