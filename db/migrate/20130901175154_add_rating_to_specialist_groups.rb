# coding: utf-8
class AddRatingToSpecialistGroups < ActiveRecord::Migration
  def change
    add_column :specialist_groups, :quality_rating, :decimal, precision: 4, scale: 1, default: 0.0
    add_column :specialist_groups, :reliability_rating, :string
  end
end
