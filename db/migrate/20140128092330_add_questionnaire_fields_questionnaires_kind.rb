class AddQuestionnaireFieldsQuestionnairesKind < ActiveRecord::Migration
  def up
  	add_column :questionnaire_fields_questionnaires, :kind, :string, :null => true, :limit => 200
  end

  def down
  	remove_column :questionnaire_fields_questionnaires, :kind
  end
end
