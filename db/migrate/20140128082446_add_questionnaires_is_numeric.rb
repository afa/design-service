class AddQuestionnairesIsNumeric < ActiveRecord::Migration
  def up
  	add_column :questionnaires, :is_numeric, :boolean, :null => false, :default => true
  end

  def down
  	remove_column :questionnaires, :is_numeric
  end
end
