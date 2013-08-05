class RemoveReplanningAttachments < ActiveRecord::Migration
  def change
    drop_table :replanning_attachments
  end
end
