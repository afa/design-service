class PhotoCollection < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_many :photos, as: :imageable_single
  accepts_nested_attributes_for :photos, allow_destroy: true

  # TODO: make preview photo changeable
  def preview_photo
    photos.first
  end
end
