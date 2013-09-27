class Payment < ActiveRecord::Base
  # attr_accessible :title, :body
 belongs_to :user
 belongs_to :order
 has_many :purchases


  state_machine :state, :initial => :created do
   state :created
   state :requested
   state :paid
   state :failed

   event :request do
    transition :created => :requested
   end
   before_transition :created => :requested, :do => :mk_purchase
   event :ok do
    transition :requested => :paid, :if => :purchase_ok?
   end
   event :bad do
    transition :requested => :failed
   end

   after_transition :requested => :paid, :do => :commit_order
  end

  def commit_order
   order.pay
  end

  def mk_purchase
   amount = order.need_amount
   purchases.create :amount => amount
  end

  def purchase_ok?
   purchases.detect{|p| p.paid? }
  end

  def regen_purchase
   unless purchase_ok? or purchases.detect{|p| p.requested? }
    mk_purchase
   end
  end
end
