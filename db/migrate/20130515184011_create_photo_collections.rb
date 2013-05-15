class CreatePhotoCollections < ActiveRecord::Migration
  def change
    create_table :photo_collections do |t|
      t.references :imageable, polymorphic: true
      t.timestamps
    end
  end
end
