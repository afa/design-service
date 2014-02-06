class AddQuestionnairesValue < ActiveRecord::Migration
  def up
  	add_column :questionnaires, :value, :text, :null => true
  end

  def down
  	remove_column :questionnaires, :value
  end
end
