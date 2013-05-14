class Review < ActiveRecord::Base
  belongs_to :order
  belongs_to :text, class_name: 'ModerableText'
end
