class AddFlatAreaToPlanDevelopments < ActiveRecord::Migration
  def change
    change_table :plan_developments do |t|
      t.decimal  "flat_area", :precision => 5, :scale => 1
    end
  end
end
