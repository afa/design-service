class MessageRemoveModerableReference < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.remove :text_id
      t.text :text
    end 
  end
end
