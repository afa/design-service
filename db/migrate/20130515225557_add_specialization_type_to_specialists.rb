class AddSpecializationTypeToSpecialists < ActiveRecord::Migration
  def change
    change_table :specialists do |t|
      t.string :specialization
      t.remove :specialist_type
    end
  end
end
