class MakeSpecializationUnique < ActiveRecord::Migration
  def change
    add_index :specializations, :name
    add_index :specializations, [:name, :sub_name], unique: true
  end
end
