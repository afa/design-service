# coding: utf-8
class AddColumnSpecialistGroupReferenceToSpecialists < ActiveRecord::Migration
  def change
    change_table :specialists do |t|
      t.references :specialist_group
    end
  end
end
