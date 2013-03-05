class CreatePlanDevelopments < ActiveRecord::Migration
  def change
    create_table :plan_developments do |t|
      t.boolean :join_kitchen_with_living_room
      t.boolean :big_kitchen
      t.boolean :cloakroom_needed
      t.boolean :cabinet_needed
      t.integer :num_builtin_closets
      t.integer :num_guests
      t.integer :num_bedrooms
      t.boolean :washing_room_needed
      t.references :flat_info

      t.timestamps
    end
    add_index :plan_developments, :flat_info_id
  end
end
