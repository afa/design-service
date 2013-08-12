class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :attachable, polymorphic: true

  def authorized?(user)
    attachable.authorized_user?(user)
  end
end
