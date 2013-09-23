class AddNumRoomsToPlanDevelopments < ActiveRecord::Migration
  def change
    add_column :plan_developments, :num_rooms, :integer
  end
end
