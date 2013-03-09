class FlatInfo < ActiveRecord::Base
  belongs_to :address
  belongs_to :family_composition, class_name: 'ModerableText'
  attr_accessible :num_standpipes

  accepts_nested_attributes_for :address, :family_composition
  attr_accessible :address_attributes, :family_composition_attributes
  
  validates :num_standpipes, numericality: true
end
