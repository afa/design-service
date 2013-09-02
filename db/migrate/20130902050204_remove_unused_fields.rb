class RemoveUnusedFields < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :access_level
    end
  end
end
