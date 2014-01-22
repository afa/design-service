class AddQuestionnaireFieldsDisplay < ActiveRecord::Migration
  def change
  	add_column :questionnaire_fields, :display, :string, :limit => 60
  end
end
