# coding: utf-8
class AttachMessageToOrder < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.references :attached_to, polymorphic: true
    end
    add_index :messages, [:attached_to_type, :attached_to_id]
  end
end
