class Payment < ActiveRecord::Base
  # attr_accessible :title, :body
 belongs_to :user
 belongs_to :order
 has_many :purchases


  state_machine :state do
   state :created
   state :requested
   state :payed
   state :failed

   event :request, :created => :requested
   event :ok, :requested => :payed
   event :fail, :requested => :fail

  end
end
