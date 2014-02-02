class AddQuestionsIsNecessarily < ActiveRecord::Migration
  def up
  	add_column :questions, :is_necessarily, :boolean, :null => false, :default => true
  end

  def down
  	remove_column :questions, :is_necessarily
  end
end
