class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :text
      t.references :user

      t.timestamps
    end
    add_index :events, :user_id
  end
end
