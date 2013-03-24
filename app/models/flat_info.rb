class FlatInfo < ActiveRecord::Base
  belongs_to :address
  belongs_to :family_composition, class_name: 'ModerableText'
  attr_accessible :num_standpipes

  accepts_nested_attributes_for :address, :family_composition
  attr_accessible :address_attributes, :family_composition_attributes
  
  #validates :num_standpipes, numericality: true
  
  # after_initialize do |flat_info|
    # flat_info.build_address  unless flat_info.read_attribute(:address)
    # flat_info.build_family_composition  unless flat_info.read_attribute(:family_composition)
  # end
  # def address; build_address  unless read_attribute(:address); read_attribute(:address); end
  # def family_composition; build_family_composition  unless read_attribute(:family_composition);read_attribute(:family_composition); end
  
end
