# coding: utf-8
class RemoveStringyArea < ActiveRecord::Migration
  def up
    SelectedForm.find_each do |orderable|
      orderable.flat_area = orderable.room_space.to_f  if orderable.room_space
      orderable.save
    end
    change_table :selected_forms do |t|
      t.remove :room_space
    end
  end
  def down
    change_table :selected_forms do |t|
      t.decimal :room_space, precision: 5, scale: 1
    end
    SelectedForm.find_each do |orderable|
        orderable.room_space = orderable.flat_area
        orderable.save
      end
  end
end
