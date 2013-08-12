class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :attachable, polymorphic: true

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
end
