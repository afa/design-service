class Order < ActiveRecord::Base
  belongs_to :orderable, polymorphic: true
  belongs_to :client, class_name: 'User'
end
