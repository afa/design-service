# coding: utf-8
class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :file
      t.references :photo_collection
      t.timestamps
    end
  end
end
