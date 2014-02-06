class AddQuestionnaireFieldsQuestionnairesIsNecessarily < ActiveRecord::Migration
  def up
  	add_column :questionnaire_fields_questionnaires, :is_necessarily, :boolean, :null => true
  end

  def down
  	remove_column :questionnaire_fields_questionnaires, :is_necessarily
  end
end
