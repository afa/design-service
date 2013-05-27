class Photo < ActiveRecord::Base
  belongs_to :imageable_single, polymorphic: true
  mount_uploader :photo, PhotoUploader
end
