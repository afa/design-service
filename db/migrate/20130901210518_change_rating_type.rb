class ChangeRatingType < ActiveRecord::Migration
  def change
    change_column :specialist_groups, :quality_rating, :integer, default: 0
  end
end
