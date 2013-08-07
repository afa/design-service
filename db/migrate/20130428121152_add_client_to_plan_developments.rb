class AddClientToPlanDevelopments < ActiveRecord::Migration
  def change
    change_table :plan_developments do |t|
      t.references :client
    end
  end
end
