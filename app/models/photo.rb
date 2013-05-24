class Photo < ActiveRecord::Base
  belongs_to :photo_collection
  mount_uploader :photo, PhotoUploader
end
