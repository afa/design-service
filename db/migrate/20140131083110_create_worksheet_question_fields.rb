class CreateWorksheetQuestionFields < ActiveRecord::Migration
  def change
    create_table :worksheet_question_fields do |t|
    	t.integer :worksheet_id, :null => false
    	t.integer :question_field_id, :null => true
    	t.text :value, :null => true
    	t.string :value_level, :null => true, :limit => 100
    	t.text :value_description, :null => true
    end

    add_index :worksheet_question_fields, :worksheet_id
    add_index :worksheet_question_fields, :question_field_id
  end
end
