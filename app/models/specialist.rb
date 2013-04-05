#encoding: utf-8
class Specialist < ActiveRecord::Base
  belongs_to :profile, class_name: 'User'
  attr_accessible :acreditation_level, :specialist_type
  has_many :portfolio_photos
  
  SPECIALIST_TYPE_ID_BY_NAME = Hash[ ["designers", "architectors", "engineers", "building_companies", "building_brigades"].map.with_index{|value,index| [value, index]} ]

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
