class CreateQuestionnaireFields < ActiveRecord::Migration
  def change
    create_table :questionnaire_fields do |t|
    	t.string :name
    end
  end
end
