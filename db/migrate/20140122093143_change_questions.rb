class ChangeQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :position, :integer, :null => true
  	add_column :questions, :name, :string, :limit => 200
  	add_column :questions, :questionnaire_id, :integer, :null => false
  	add_column :questions, :count_true, :integer, :null => true
  	add_column :questions, :count_all, :integer, :null => true
  	add_column :questions, :statis_is_true, :boolean, :null => true

  	remove_column :questions, :created_at
  	remove_column :questions, :updated_at

  	add_index :questions, :questionnaire_id
  end
end
