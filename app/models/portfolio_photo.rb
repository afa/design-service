class PortfolioPhoto < ActiveRecord::Base
  belongs_to :specialist
  mount_uploader :file, PhotoUploader
end
