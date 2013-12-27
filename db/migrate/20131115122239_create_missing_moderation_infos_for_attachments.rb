# coding: utf-8
class CreateMissingModerationInfosForAttachments < ActiveRecord::Migration
  def up
    Attachment.find_each do |attachment|
      attachment.create_moderation_info  unless attachment.moderation_info
    end
  end

  def down
  end
end
