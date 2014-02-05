class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
    	t.string :name
    	t.integer :specialization_id
    end

    add_index :questionnaires, :specialization_id
  end
end