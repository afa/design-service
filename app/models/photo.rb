class Photo < ActiveRecord::Base
  belongs_to :photo_collection
  mount_uploader :file, PhotoUploader
end
