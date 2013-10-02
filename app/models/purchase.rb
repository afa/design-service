class Purchase < ActiveRecord::Base
 belongs_to :payment
 belongs_to :user
 belongs_to :order

 state_machine :state, :initial => :requested do
  state :requested
  state :paid
  state :failed
  event :ok do
   transition :requested => :paid
  end
  event :bad do
   transition :requested => :failed
  end
  after_transition :requested => :paid, :do => :commit_payment
  after_transition :requested => :failed, :do => :renew_payment
 end
  def commit_payment
   order.transactions.create :destination => user, :amount => amount
   payment.ok
  end

  def renew_payment
   payment.regen_purchase
  end

  def robo_info
   iface = Rubykassa::XmlInterface.new
   iface.invoice_id = id
   xml = iface.op_state.try(:[], "OperationStateResponse")
  end
end
