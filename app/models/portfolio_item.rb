class PortfolioItem < ActiveRecord::Base
  belongs_to :portfolio
  mount_uploader :photo, PhotoUploader
end
