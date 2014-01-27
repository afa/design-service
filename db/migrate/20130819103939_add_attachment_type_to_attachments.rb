# coding: utf-8
class AddAttachmentTypeToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :kind, :string
  end
end
