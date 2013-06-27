class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.string :middle_name
      t.string :fake_name
      t.references :user

      t.timestamps
    end
    add_index :profiles, :user_id
    change_table :users do |t|
      t.remove :name
      t.remove :surname
      t.remove :middle_name
    end
  end
end
