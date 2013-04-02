class CreateSpecialists < ActiveRecord::Migration
  def change
    create_table :specialists do |t|
      t.integer :type
      t.integer :acreditation_level
      t.references :profile, null: false

      t.timestamps
    end
    add_index :specialists, :profile_id
  end
end
