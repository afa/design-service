# coding: utf-8
class AddUserUploadedToAttachments < ActiveRecord::Migration
  def change
    change_table :attachments do |t|
      t.references :user, null: false
    end
    add_index :attachments, :user_id
  end
end
