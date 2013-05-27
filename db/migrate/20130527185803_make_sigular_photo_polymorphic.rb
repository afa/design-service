class MakeSigularPhotoPolymorphic < ActiveRecord::Migration
  def change
    change_table :photos do |t|
      t.remove :photo_collection_id
      t.references :imageable_single, polymorphic: true
    end
    add_index :photos, :imageable_single_type
    add_index :photos, :imageable_single_id
  end
end
