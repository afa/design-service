class AddDecimalArea < ActiveRecord::Migration
  def up
    change_table :selected_forms do |t|
      t.decimal :flat_area, precision: 5, scale: 1
    end
  end
  def down
    change_table :selected_forms do |t|
      t.remove :flat_area
    end
  end
end
