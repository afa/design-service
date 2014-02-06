# coding: utf-8
class FixPolymorphicIndices < ActiveRecord::Migration
  def change
    remove_index :photos, :imageable_single_id
    remove_index :photos, :imageable_single_type
    add_index :photos, [:imageable_single_type, :imageable_single_id]
  end
end
