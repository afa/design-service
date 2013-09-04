class PortfolioItem < ActiveRecord::Base
  has_and_belongs_to_many :portfolios
  mount_uploader :photo, PhotoUploader
end
