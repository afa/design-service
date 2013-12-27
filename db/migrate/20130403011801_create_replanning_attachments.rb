# coding: utf-8
class CreateReplanningAttachments < ActiveRecord::Migration
  def change
    create_table :replanning_attachments do |t|
      t.string :file
      t.references :replanning_endorsement

      t.timestamps
    end
    add_index :replanning_attachments, :replanning_endorsement_id
  end
end
