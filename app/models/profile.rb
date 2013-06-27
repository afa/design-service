class Profile < ActiveRecord::Base
  belongs_to :user
  #attr_accessible :fake_name, :middle_name, :name, :surname
end
