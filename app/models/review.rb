class Review < ActiveRecord::Base
  belongs_to :order, counter_cache: true
  belongs_to :text, class_name: 'ModerableText'
end
