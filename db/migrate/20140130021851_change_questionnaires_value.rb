class ChangeQuestionnairesValue < ActiveRecord::Migration
  def up
  	remove_column :questionnaires, :value
  	add_column :questions, :value, :text, :null => true
  end

  def down
  	add_column :questionnaires, :value, :text, :null => true
  	remove_column :questions, :value
  end
end
