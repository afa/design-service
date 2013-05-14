class Review < ActiveRecord::Base
  belongs_to :order, counter_cache: true
  belongs_to :text, class_name: 'ModerableText'
  accepts_nested_attributes_for :text
end
