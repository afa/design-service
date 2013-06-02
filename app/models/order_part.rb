class OrderPart < ActiveRecord::Base
  belongs_to :order
  belongs_to :executor, class_name: 'Specialist', foreign_key: 'specialist_id'
  attr_accessible :status
end
