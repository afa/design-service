class CreateRequestSpecialists < ActiveRecord::Migration
  def change
    create_table :request_specialists do |t|
    	t.references :specialist_group
    	t.references :specialist
    	t.integer :join_specialist_id
    	t.boolean :status, :null => true
		t.timestamps
    end

    add_index :request_specialists, :specialist_group_id
    add_index :request_specialists, :specialist_id
    add_index :request_specialists, :join_specialist_id
  end
end
