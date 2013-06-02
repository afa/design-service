class ReviewModerableTextToPapertrail < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.remove :text_id
      t.text :text
    end
  end
end
