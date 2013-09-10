class CreatSelectedForms < ActiveRecord::Migration
def change
    create_table :selected_forms do |t|
      t.string :room_space
      t.string :interior_style
      t.string :show_results
      t.text :wishes
      t.references :order_customizer


      t.timestamps
    end
    add_index :selected_forms, :order_customizer_id
  end
end