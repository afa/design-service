class AddQuestionnaireFieldsQuestionnairesPosition < ActiveRecord::Migration
  def up
  	add_column :questionnaire_fields_questionnaires, :position, :integer, :null => true
  	add_column :questionnaire_fields_questionnaires, :location, :string, :null => true, :limit => 30
  end

  def down
  	remove_column :questionnaire_fields_questionnaires, :position
  	remove_column :questionnaire_fields_questionnaires, :location
  end
end
