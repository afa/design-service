class CreateWorksheetExperiences < ActiveRecord::Migration
  def change
    create_table :worksheet_experiences do |t|
    	t.string :name, :null => true, :limit => 1000
    	t.string :position, :null => true, :limit => 1000
    	t.text :responsibility, :null => true
    	t.date :date_start, :null => true
    	t.date :date_last, :null => true
    	t.string :sity, :null => true, :limit => 100
    	t.string :country, :null => true, :limit => 100
    	t.string :region, :null => true, :limit => 100
    	t.integer :worksheet_id, :null => false
      	t.timestamps
    end
  end
end
