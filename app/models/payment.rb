class Payment < ActiveRecord::Base
  # attr_accessible :title, :body
 belongs_to :user
 belongs_to :order
 has_many :purchases


  state_machine :state, :initial => :created do
   state :created
   state :requested
   state :payed
   state :failed

   event :request do
    transition :created => :requested
   end
   before_transition :created => :requested, :do => :mk_purchase
   event :ok do
    transition :requested => :payed, :if => :purchase_ok?
   end
   event :bad do
    transition :requested => :failed
   end

   after_transition :requested => :payed, :do => :commit_order
  end

  def commit_order
   order.ok
  end

  def mk_purchase
   purchases.create 
  end

  def purchase_ok?
   purchases.detect{|p| p.paid? }
  end
end
