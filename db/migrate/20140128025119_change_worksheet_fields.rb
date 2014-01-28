class ChangeWorksheetFields < ActiveRecord::Migration
  def up
  	remove_column :worksheet_fields, :journal_questionnaire_field_id
  	add_column :worksheet_fields, :questionnaire_fields_questionnaire_id, :integer, :null => false
  	change_column :worksheet_fields, :worksheet_id, :integer, :null => true
  end

  def down
  	remove_column :worksheet_fields, :questionnaire_fields_questionnaire_id
  	add_column :worksheet_fields, :journal_questionnaire_field_id, :integer, :null => false
  	change_column :worksheet_fields, :worksheet_id, :integer, :null => false
  end
end