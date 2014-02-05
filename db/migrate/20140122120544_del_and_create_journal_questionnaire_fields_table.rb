class DelAndCreateJournalQuestionnaireFieldsTable < ActiveRecord::Migration
  def up
  	drop_table :journal_questionnaire_fields

  	create_table :journal_questionnaire_fields, :id => false do |t|
        t.references :questionnaire_field
        t.references :questionnaire
        t.string :value, :limit => 500
    end
    add_index :journal_questionnaire_fields, [:questionnaire_field_id, :questionnaire_id], :name => "journal_questionnaire_fields_qf_q"
    add_index :journal_questionnaire_fields, :questionnaire_id, :name => "journal_questionnaire_fields_q"
  end

  def down
  	drop_table :journal_questionnaire_fields
  end
end
