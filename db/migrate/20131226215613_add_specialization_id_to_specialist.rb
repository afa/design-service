class AddSpecializationIdToSpecialist < ActiveRecord::Migration
  def change
  	add_column :specialists, :specialization_id, :integer
  end
end
