class CreatePortfolioPhotos < ActiveRecord::Migration
  def change
    create_table :portfolio_photos do |t|
      t.string :file
      t.references :specialist

      t.timestamps
    end
    add_index :portfolio_photos, :specialist_id
  end
end
