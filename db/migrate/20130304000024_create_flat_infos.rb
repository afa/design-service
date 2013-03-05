class CreateFlatInfos < ActiveRecord::Migration
  def change
    create_table :flat_infos do |t|
      t.references :address
      t.integer :num_standpipes
      t.references :family_composition

      t.timestamps
    end
    add_index :flat_infos, :address_id
    add_index :flat_infos, :family_composition_id
  end
end
