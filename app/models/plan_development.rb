#encoding: utf-8
class PlanDevelopment < ActiveRecord::Base
  # after_initialize do |plan_development|
    # plan_development.build_flat_info  unless plan_development.read_attribute(:flat_info)
    # plan_development.build_attachment  unless plan_development.read_attribute(:attachment)
    # plan_development.build_comment  unless plan_development.read_attribute(:comment)
  # end
  belongs_to :flat_info
  #has_one :family_composition, through: :flat_info
  #has_one :address, through: :flat_info
  belongs_to :comment, class_name: 'ModerableText'
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
  #validates :num_builtin_closets, numericality: true
  
  NUM_GUESTS = ["Нет", "До 5", "5-15", "Более 15"].map.with_index{|value,index| [index,value]}
  KITCHEN_SIZE = [[true, 'Больше 15 кв.м.<br/>'.html_safe],[false, 'Меньше 15 кв.м.']]

  accepts_nested_attributes_for :flat_info, :attachment, :comment
  attr_accessible :flat_info_attributes, :address_attributes, :comment_attributes
  
  # def flat_info; build_flat_info  unless read_attribute(:flat_info_id); read_attribute(:flat_info); end
  # def comment; build_comment  unless read_attribute(:comment); read_attribute(:comment) end
  # def attachment; build_attachment  unless read_attribute(:attachment); read_attribute(:attachment) end
  
  # def family_first_line=(value)
  
   # puts "\n\n================================\nHEREEEEEEEEEEEEEEEEEE!!!!!!!!\n===============================\n\n"
   # @family_first_line = value
   # set_family_info
   # puts flat_info.inspect
  # end
  # def family_second_line=(value)
   # @family_second_line = value
   # set_family_info
  # end
  # def set_family_info
   # flat_info.family_composition.text = "#{family_first_line} #{family_second_line}"
  # end
end
