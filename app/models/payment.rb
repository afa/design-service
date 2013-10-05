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
    transition :requested => :requested
   end
   event :bad do
    transition :requested => :failed
   end

   after_transition :requested => :paid, :do => :commit_order
   after_transition :requested => :requested, :do => :regen_purchase
  end

  def commit_order
   order.pay if order
  end

  def mk_purchase
   #amount = order.need_amount - paid_amount
   purchases.create :amount => (amount || 0.0) - paid_amount, :user_id => user_id, :order_id => order_id
  end

  def purchase_ok?
   paid_amount >= amount
  end

  def regen_purchase
   purchases.where(:state => :requested).update_all("state = 'failed'")
   mk_purchase
  end

  def paid_amount
   purchases.where(:state => :paid).inject(0.0){|r, p| r + p.amount }
  end
end
