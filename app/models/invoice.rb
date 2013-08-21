class Invoice < ActiveRecord::Base
 belongs_to :specialist
 belongs_to :order

 state_machine :state, :initial => :created do
  state :created
  #state

 end
end
