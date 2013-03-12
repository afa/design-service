#encoding: utf-8
class PlanDevelopment < ActiveRecord::Base
  belongs_to :flat_info
  belongs_to :attachment
  attr_accessible :big_kitchen,
  				  :cabinet_needed,
  				  :cloakroom_needed,
  				  :join_kitchen_with_living_room,
  				  :num_bedrooms,
  				  :num_builtin_closets,
  				  :num_guests,
  				  :washing_room_needed,
  				  :num_plans,
  				  :attachment_attributes
  
  #validates :num_guests, numericality: true
  validates :num_builtin_closets, numericality: true
  
  NUM_GUESTS = ["Нет", "До 5", "5-15", "Более 15"].map.with_index{|value,index| [index,value]}

  accepts_nested_attributes_for :flat_info
  accepts_nested_attributes_for :attachment
  attr_accessible :flat_info_attributes
end
