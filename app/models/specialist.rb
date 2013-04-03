#encoding: utf-8
class Specialist < ActiveRecord::Base
  belongs_to :profile, class_name: 'User'
  attr_accessible :acreditation_level, :specialist_type
  has_many :portfolio_photos
  
  #SPECIALIZATION = {'designers' => 'Дизайнер' }
  #SPECIALIST_TYPES = ["Дизайнер", "Архитектор", "Инженер", "Строительная фирма", "Строительная бригада"].map.with_index{|value,index| [index,value]}
  
  scope :specialization, ->(specialist_type){ where(specialist_type: specialist_type) }
  def rating
    666
  end
  def rating_count
    777
  end
  def positive_feedback
   '100500'
  end
  def negative_feedback
    '0'
  end
  
end
