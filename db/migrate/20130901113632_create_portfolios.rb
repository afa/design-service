class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.references :owner, polymorphic: true, null: false

      t.timestamps
    end
    add_index :portfolios, [:owner_type, :owner_id]
  end
end
