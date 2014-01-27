class CreateWorksheets < ActiveRecord::Migration
  def change
    create_table :worksheets do |t|
    	t.integer :questionnaire_id, :null => false
      	t.timestamps
    end

    add_index :worksheets, :questionnaire_id, :name => "ix_worksheets_questionnaire_id"
  end
end
