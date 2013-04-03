class RenameColumn < ActiveRecord::Migration
  def change
    change_table :specialists do |t|
      t.rename :type, :specialist_type
    end
  end
end
