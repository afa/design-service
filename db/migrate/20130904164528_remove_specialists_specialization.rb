class RemoveSpecialistsSpecialization < ActiveRecord::Migration
  def change
    remove_column :specialists, :specialization
  end
end