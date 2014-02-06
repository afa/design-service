class DelAndCreateJournalQuestionnaireFieldsTable2 < ActiveRecord::Migration
  def up
  	drop_table :journal_questionnaire_fields

  	create_table :questionnaire_fields_questionnaires, :id => false do |t|
        t.references :questionnaire_field
        t.references :questionnaire
        t.string :value, :limit => 500
    end
    add_index :questionnaire_fields_questionnaires, [:questionnaire_field_id, :questionnaire_id], :name => "questionnaire_fields_questionnaires_qf_q"
    add_index :questionnaire_fields_questionnaires, :questionnaire_id, :name => "questionnaire_fields_questionnaires_q"
  end

  def down
  	drop_table :questionnaire_fields_questionnaires
  end
end
