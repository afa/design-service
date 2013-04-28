class Client < ActiveRecord::Base
  belongs_to :profile, class_name:'User'
  has_many :plan_developments
end
