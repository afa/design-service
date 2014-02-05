class CreateWorksheetEducations < ActiveRecord::Migration
  def change
    create_table :worksheet_educations do |t|
    	t.string :type_education, :null => true, :limit => 100
    	t.string :name, :null => true, :limit => 1000
    	t.date :date_last, :null => true
    	t.integer :worksheet_id, :null => true
    end

    add_index :worksheet_educations, :worksheet_id
    add_index :worksheet_experiences, :worksheet_id
  end
end
