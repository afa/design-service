class MakePortfolioItemBelongsToSpecialistToo < ActiveRecord::Migration
  def change
    change_table :portfolio_items do |t|
      t.references :specialist_group
      t.references :specialist
    end
  end
end
