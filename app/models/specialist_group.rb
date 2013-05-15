class SpecialistGroup < ActiveRecord::Base
  has_many :specialists
  has_many :portfolio_items, include: :photo_collection
end
