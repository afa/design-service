class PortfolioItem < ActiveRecord::Base
  has_one :photo_collection, as: :imageable
  #has_many :photos, through: :photo_collection
  has_one :specialist_group, through: :specialist
  belongs_to :specialist

  delegate :preview_photo, to: :photo_collection

  accepts_nested_attributes_for :photo_collection, allow_destroy: true

  extend Enumerize
  enumerize :specialization, in: [:designer, :architector, :engineer, :building_company, :building_brigade, :not_a_specialist], default: :not_a_specialist

  # TODO: make rating calcualtion
  def rating; 7; end
end
