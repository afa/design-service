class PortfolioPhoto < ActiveRecord::Base
  belongs_to :specialist
  attr_accessible :file
  mount_uploader :file, PhotoUploader
end
