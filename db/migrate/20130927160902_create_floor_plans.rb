class CreateFloorPlans < ActiveRecord::Migration
  def change
    create_table :floor_plans do |t|
      t.string :room
      t.boolean :artificial_cold
      t.boolean :artificial_warm
      t.boolean :carpet_or_printed_carpet
      t.boolean :stone
      t.boolean :tree
      t.references :selected_form
      t.timestamps
    end
    add_index :floor_plans, :selected_form_id
  end
end
