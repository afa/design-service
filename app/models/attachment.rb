# coding: utf-8
class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :attachable, polymorphic: true
  belongs_to :user
  before_save :check_attachment_kind, :remove_attachments_of_the_same_kind
  before_create :build_moderation_info

  # TODO: extract to a module ActsAsModerable (included into attachments and messages). Be careful with user_id in `_or_self` clause: it refers to different collection,
  has_one :moderation_info, as: :moderable, class_name: 'Moderation'
  delegate :accepted?, :rejected?, to: :moderation_info
  # scope :accepted, ->{ joins(:moderation_info).where(moderations: {status: [:accepted_complete, :accepted_automatically]}) }
  # scope :to_be_shown, ->(user_id){ ###accepted or sent### }
  scope :accepted_or_self, ->{ joins(:moderation_info).where('"moderations"."status" IN(\'accepted_complete\',\'accepted_automatically\') OR "attachments"."user_id" = :user_id', user_id: User.current.id) }
  scope :to_be_moderated, ->{ joins(:moderation_info).where(moderations: {status: :not_accepted}) }


  def authorized?(user)
    attachable.authorized_user?(user)
  end

  # 'xxx.jpg'
  def original_filename
    file.file.original_filename
  end

  # /usr/home/me/uploads/attachment/file/1/xxx.jpg
  def path
    file.file.file
  end

  # 'image/jpeg'
  def content_type
    file.set_content_type
    file.file.content_type
  end

private

  # Possibly we should create two groups of kinds: those having the only attachment and others which have many.
  # Because now user can attach lots of photos instead of 1 pdf, I comment out this string
  def remove_attachments_of_the_same_kind
  #  attachable.attachments.where(kind: self.kind).destroy
  end

  def check_attachment_kind
    return true  if !self.kind  # temporary line for migration purposes
    return true  if !attachable.respond_to?(:attachment_kinds)

    if !attachable.attachment_kinds.include?(self.kind)
      raise "This object can't has attachments of kind :'#{self.kind}'"
    end
  end
end
