class CreateSpecialistLikes < ActiveRecord::Migration
  def change
    create_table :specialist_likes, id: false do |t|
      t.references :specialist
      t.references :user
    end
    add_index :specialist_likes, :specialist_id
    add_index :specialist_likes, :user_id
  end
end
