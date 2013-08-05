class OrderToSpecialist < ActiveRecord::Base
  belongs_to :executor
  attr_accessible :description
end
