# coding: utf-8
class RenameColumnInPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :file, :photo
  end
end
