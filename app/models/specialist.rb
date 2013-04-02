class Specialist < ActiveRecord::Base
  belongs_to :profile, class_name: 'User'
  #attr_accessible :acreditation_level, :type
  
end
