class ChangeColumnTpeForEngineeringSystems < ActiveRecord::Migration
  def change
    change_table :engineering_systems do |t|
      t.remove :wishes_id
      t.text :wishes
    end
  end
end
