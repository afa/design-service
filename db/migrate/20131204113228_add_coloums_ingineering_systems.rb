# coding: utf-8
class AddColoumsIngineeringSystems < ActiveRecord::Migration
  def up
    add_column :engineering_systems, :light_control, :boolean
    add_column :engineering_systems, :access_control, :boolean
    add_column :engineering_systems, :mood_control, :boolean
  end

  def down
    remove_column :engineering_systems, :light_control
    remove_column :engineering_systems, :access_control
    remove_column :engineering_systems, :mood_control    
  end
end