class AddQuestionnaireFieldsQuestionnairesId < ActiveRecord::Migration
  def up
  	add_column :questionnaire_fields_questionnaires, :id, :primary_key
  end

  def down
  end
end
