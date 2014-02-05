class AddQuestionsKind < ActiveRecord::Migration
  def up
  	add_column :questions, :kind, :string, :null => true, :limit => 200
  end

  def down
  	remove_column :questions, :kind
  end
end
