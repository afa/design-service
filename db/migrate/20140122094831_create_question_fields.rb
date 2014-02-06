class CreateQuestionFields < ActiveRecord::Migration
  def change
    create_table :question_fields do |t|
    	t.string :name, :limit => 1000
    	t.text :value, :null => true
    	t.integer :question_id, :null => false
    	t.string :display, :limit => 100
    end

    add_index :question_fields, :question_id
  end
end
