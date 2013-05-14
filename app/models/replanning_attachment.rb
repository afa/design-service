class ReplanningAttachment < ActiveRecord::Base
  belongs_to :replanning_endorsement
  mount_uploader :file, FileUploader
end
