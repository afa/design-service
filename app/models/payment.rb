class Payment < ActiveRecord::Base
  # attr_accessible :title, :body
 belongs_to :user
 belongs_to :order
 has_many :purchases


  state_machine :state, :initial => :created do
   state :created do
   end
   state :requested
   state :payed
   state :failed

   event :request do
    transition :created => :requested
   end
   event :ok do
    transition :requested => :payed
   end
   event :fail do
    transition :requested => :fail
   end
  end
end
