class ChangeCpecializationForSpecialists < ActiveRecord::Migration
  def change
    change_column :specialists, :specialization, :string, default: :not_a_specialist
  end
end
