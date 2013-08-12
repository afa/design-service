class NotNullableAttachable < ActiveRecord::Migration
  def change
    Attachment.where(attachable_id: nil).delete_all
    Attachment.where(attachable_type: nil).delete_all
    Attachment.where(file: nil).delete_all
    change_column :attachments, :attachable_id, :integer, null: false
    change_column :attachments, :attachable_type, :string, null: false
    change_column :attachments, :file, :string, null: false
  end
end
