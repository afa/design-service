class CreateFloorPlans < ActiveRecord::Migration
  def change
    create_table :floor_plans do |t|

      t.timestamps
    end
  end
end
