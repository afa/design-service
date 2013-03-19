class Message < ActiveRecord::Base
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'
  belongs_to :text, class_name: 'ModerableText'
  
  accepts_nested_attributes_for :text
  attr_accessible :text_attributes
end
