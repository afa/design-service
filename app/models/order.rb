class Order < ActiveRecord::Base
  belongs_to :orderable, polymorphic: true
  belongs_to :client
  # attr_accessible :completion_status
end
