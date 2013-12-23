# coding: utf-8
class AddAttachableToAttachment < ActiveRecord::Migration
  def change
    change_table :attachments do |t|
      t.references :attachable, polymorphic: true
    end
    add_index :attachments, [:attachable_type, :attachable_id]
  end
end
