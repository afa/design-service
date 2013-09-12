class Purchase < ActiveRecord::Base
 belongs_to :payment
 belongs_to :user

 state_machine :state, :initial => :requested do
  state :requested
  state :payed
  state :failed
  event :ok do
   transition :requested => :payed, :do => :commit_payment
  end
 end
  def commit_payment
   payment.order.transactions.create :destination => user, :amount => amount
   payment.ok
  end
end
