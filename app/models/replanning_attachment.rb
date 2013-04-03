class ReplanningAttachment < ActiveRecord::Base
  belongs_to :replanning_endorsement
  attr_accessible :file
  mount_uploader :file, FileUploader
end
