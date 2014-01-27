class CreateWorksheetFields < ActiveRecord::Migration
  def change
    create_table :worksheet_fields do |t|
    	t.integer :journal_questionnaire_field_id, :null => false
    	t.integer :worksheet_id, :null => false
    	t.text :value, :null => true
    end

    add_index :worksheet_fields, :journal_questionnaire_field_id, :name => "worksheet_fields_jqfi"
    add_index :worksheet_fields, :worksheet_id, :name => "worksheet_fields_wi"
  end
end
