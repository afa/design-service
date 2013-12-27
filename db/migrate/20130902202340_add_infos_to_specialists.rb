# coding: utf-8
class AddInfosToSpecialists < ActiveRecord::Migration
  def change
    add_column :specialists, :bio_info, :text
    add_column :specialists, :work_info, :text
  end
end
