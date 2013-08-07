class AddClientStr < ActiveRecord::Migration
  def up
    if !(PlanDevelopment.new.attributes.has_key?(:client) && PlanDevelopment.new.attributes.has_key?(:client_id))
     add_column :plan_developments, :client, :string
    end
  end
  def down

  end
end
