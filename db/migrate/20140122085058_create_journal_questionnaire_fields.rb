class CreateJournalQuestionnaireFields < ActiveRecord::Migration
  def change
    create_table :journal_questionnaire_fields do |t|
    	t.integer :questionnaire_id
    	t.integer :questionnaire_field_id
    	t.string :value, :limit => 500
    end

    add_index :journal_questionnaire_fields, :questionnaire_id
    add_index :journal_questionnaire_fields, :questionnaire_field_id
  end
end
