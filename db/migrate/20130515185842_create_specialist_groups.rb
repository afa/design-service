class CreateSpecialistGroups < ActiveRecord::Migration
  def change
    create_table :specialist_groups do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
