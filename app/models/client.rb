class Client < ActiveRecord::Base
  belongs_to :profile, class_name:'User'
  has_many :orders
end