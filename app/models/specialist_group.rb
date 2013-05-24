class SpecialistGroup < ActiveRecord::Base
  has_many :specialists
  has_many :portfolio_items, through: :specialists, include: :photo_collection
end
