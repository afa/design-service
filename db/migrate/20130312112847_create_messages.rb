# coding: utf-8
class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :from
      t.references :to
      t.references :text

      t.timestamps
    end
    add_index :messages, :from_id
    add_index :messages, :to_id
    add_index :messages, :text_id
  end
end
