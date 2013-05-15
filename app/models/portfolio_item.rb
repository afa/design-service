class PortfolioItem < ActiveRecord::Base
  has_one :photo_collection, as: :imageable
end
