#encoding: utf-8
class PlanDevelopment < ActiveRecord::Base
  belongs_to :comment, class_name: 'ModerableText'
  belongs_to :attachment
  belongs_to :family_composition, class_name: 'ModerableText'
  # attr_accessible :big_kitchen,
  				  # :cabinet_needed,
  				  # :cloakroom_needed,
  				  # :join_kitchen_with_living_room,
  				  # :num_bedrooms,
  				  # :num_builtin_closets,
  				  # :num_guests,
  				  # :washing_room_needed,
  				  # :num_plans,
  				  # :attachment_attributes
  accepts_nested_attributes_for :attachment, :comment
  # attr_accessible :address_attributes, :comment_attributes

  #validates :num_guests, numericality: true
  #validates :num_builtin_closets, numericality: true

  NUM_GUESTS = ["Нет", "До 5", "5-15", "Более 15"].map.with_index{|value,index| [index,value]}
  KITCHEN_SIZE = [[true, 'Больше 15 кв.м.<br/>'.html_safe],[false, 'Меньше 15 кв.м.']]
end
