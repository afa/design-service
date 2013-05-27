class RemoveAccreditationLevel < ActiveRecord::Migration
  def change
    change_table :specialists do |t|
      t.remove :acreditation_level
    end
  end

  def down
  end
end
