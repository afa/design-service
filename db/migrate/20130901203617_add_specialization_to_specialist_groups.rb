# coding: utf-8
class AddSpecializationToSpecialistGroups < ActiveRecord::Migration
  def change
    add_column :specialist_groups, :specialization, :string, default: :not_a_specialist
  end
end
